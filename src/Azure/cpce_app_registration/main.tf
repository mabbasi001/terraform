locals {
  environment_aad = var.environment_code == "prod" ? "" : replace(trimspace("${var.environment_code} ${var.branch_name} ${var.configuration_name}"), "_", "")
  display_name = trim(
    format("%s %s %s",
      local.environment_aad,
      replace(var.application_name, ".", " "),
      var.unique_suffix
    ),
    " "
  )

  key         = replace(lower(trim(format("%s %s %s", local.environment_aad, replace(var.application_name, " ", ""), var.domain), " ")), " ", ".")
  app_id_url  = "https://${local.key}"
  secret_name = replace("${local.key}-secret", ".", "-")

  # api_permissions need to be modified twice
  # to calcualte correct display name 
  # to filter based on existing apis
  api_permissions = var.api_permissions == null ? {} : {
    for key, item in var.api_permissions : trim(format("%s %s %s",
      local.environment_aad,
      replace(key, ".", " "),
      var.unique_suffix
    ), " ") => merge(item, { original_name = key })
  }

  api_permissions_enriched = {
    for key, item in local.api_permissions : key => merge(item, {
      application_id = (item.application_id == "" || item.application_id == null) && !item.is_managed_resource ? data.external.existing_apis[key].result.appId : item.application_id
      // app_id_uri: only for those who provide a display name ONLY
      app_id_uri = (item.application_id == "" || item.application_id == null) && !item.is_managed_resource ? coalesce(
        data.external.existing_apis[key].result.appIdUri,
      replace(lower(trim(format("https://%s %s %s", local.environment_aad, replace(item.original_name, " ", ""), var.domain), " ")), " ", ".")) : item.application_id
    })
  }

  api_permissions_flattened = flatten([
    for key, ap in local.api_permissions_enriched : [
      for rs_key, rs in ap.resource_access : {
        application_id                              = ap.application_id
        managed_resource_application_id             = ap.managed_resource_application_id
        managed_resource_serviceprincipal_object_id = ap.managed_resource_serviceprincipal_object_id
        resource_access_type                        = rs.type
        ap_key                                      = key
        rs_key                                      = rs_key
        managed_resource_resource_access_id         = rs.managed_resource_resource_access_id
        is_managed_resource                         = ap.is_managed_resource
      }
    ]
  ])
}

resource "time_offset" "two_years" {
  offset_years = 2
}

data "external" "existing_apis" {
  for_each = { for k, v in local.api_permissions : k => v if !v.is_managed_resource && (v.application_id == "" || v.application_id == null) }
  program = [
    "az",
    "ad",
    "sp",
    "list",
    "--filter",
    "displayName eq '${each.key}'",
    "--query",
    "{displayName: [0].displayName, appId: [0].appId, appIdUri: [0].servicePrincipalNames[0]}"
  ]
}

# owner
data "azuread_client_config" "current" {}

data "azuread_service_principal" "down_stream_apis" {
  for_each       = { for k, v in local.api_permissions_enriched : v.application_id => v if !v.is_managed_resource && v.application_id != "" }
  application_id = each.value.application_id
}

resource "azuread_application" "application" {
  display_name                   = local.display_name
  fallback_public_client_enabled = var.is_public_client
  identifier_uris                = [local.app_id_url]
  owners                         = [data.azuread_client_config.current.object_id]
  sign_in_audience               = var.sign_in_audience

  api {
    requested_access_token_version = 2

    dynamic "oauth2_permission_scope" {
      for_each = var.scopes
      content {
        admin_consent_description  = oauth2_permission_scope.value.description
        admin_consent_display_name = oauth2_permission_scope.key
        user_consent_description   = oauth2_permission_scope.value.description
        user_consent_display_name  = oauth2_permission_scope.key
        enabled                    = true
        id                         = oauth2_permission_scope.value.uid
        value                      = oauth2_permission_scope.key
        type                       = oauth2_permission_scope.value.type
      }
    }

  }

  dynamic "web" {
    for_each = contains(keys(var.redirect_uris), "web") || length(var.implicit_grant) > 0 ? [1] : []

    content {
      redirect_uris = contains(keys(var.redirect_uris), "web") ? values(var.redirect_uris["web"]) : []
      implicit_grant {
        access_token_issuance_enabled = contains(var.implicit_grant, "access_token")
        id_token_issuance_enabled     = contains(var.implicit_grant, "id_token")
      }

    }
  }

  dynamic "single_page_application" {
    for_each = contains(keys(var.redirect_uris), "spa") ? [1] : []

    content {
      redirect_uris = values(var.redirect_uris["spa"])
    }
  }

  dynamic "public_client" {
    for_each = contains(keys(var.redirect_uris), "public_client") ? [1] : []

    content {
      redirect_uris = values(var.redirect_uris["public_client"])
    }
  }

  dynamic "app_role" {
    for_each = var.app_roles
    content {
      allowed_member_types = lookup(
        {
          Application = ["Application"],
          User        = ["User"],
          All         = ["Application", "User"]
        },
        coalesce(app_role.value.allowed_member_types, "Application"), ["Application"]
      )
      description  = coalesce(app_role.value.description, app_role.key)
      display_name = app_role.key
      enabled      = true
      value        = app_role.key
      id           = app_role.value.uid
    }
  }

  dynamic "required_resource_access" {
    for_each = { for k, v in local.api_permissions_enriched : k => v if v.application_id != "" && !v.is_managed_resource }
    content {
      resource_app_id = required_resource_access.value.application_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.type == "Role" ? data.azuread_service_principal.down_stream_apis[required_resource_access.value.application_id].app_role_ids["${resource_access.key}"] : data.azuread_service_principal.down_stream_apis[required_resource_access.value.application_id].oauth2_permission_scope_ids["${resource_access.key}"]
          type = resource_access.value.type
        }
      }
    }
  }

  dynamic "required_resource_access" {
    for_each = { for k, v in local.api_permissions_enriched : k => v if v.is_managed_resource }
    content {
      resource_app_id = required_resource_access.value.managed_resource_application_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.managed_resource_resource_access_id
          type = resource_access.value.type
        }
      }
    }
  }

  dynamic "optional_claims" {
    for_each = length(var.optional_claims) > 0 ? [1] : []

    content {
      dynamic "access_token" {
        for_each = contains(keys(var.optional_claims), "access_tokens") ? var.optional_claims["access_tokens"] : []
        content {
          name = access_token.value
        }
      }
    }
  }
}

# grant admin consent service principal
resource "azuread_service_principal" "application" {
  application_id = azuread_application.application.application_id
}

resource "azuread_app_role_assignment" "application_calling_downstream_apis" {
  for_each = {
    for item in local.api_permissions_flattened : "${item.ap_key}.${item.rs_key}" => item if var.grant_admin_consent && item.resource_access_type == "Role" && item.application_id != "" && !item.is_managed_resource
  }

  app_role_id         = data.azuread_service_principal.down_stream_apis[each.value.application_id].app_role_ids[each.value.rs_key]
  principal_object_id = azuread_service_principal.application.object_id
  resource_object_id  = data.azuread_service_principal.down_stream_apis[each.value.application_id].object_id
}

resource "azuread_app_role_assignment" "application_calling_downstream_apis_managed_resource" {
  for_each = {
    for item in local.api_permissions_flattened : "${item.ap_key}.${item.rs_key}" => item if var.grant_admin_consent && item.resource_access_type == "Role" && item.is_managed_resource
  }

  app_role_id         = each.value.managed_resource_resource_access_id
  principal_object_id = azuread_service_principal.application.object_id
  resource_object_id  = each.value.managed_resource_serviceprincipal_object_id
}

# grant admin consent user
resource "azuread_service_principal_delegated_permission_grant" "application_calling_downstream_apis" {
  for_each = {
    for key, item in local.api_permissions_enriched : key => item if var.grant_admin_consent && contains([for r in item.resource_access : r.type], "Scope") && item.application_id != "" && !item.is_managed_resource
  }

  service_principal_object_id          = azuread_service_principal.application.object_id
  resource_service_principal_object_id = data.azuread_service_principal.down_stream_apis[each.value.application_id].object_id
  claim_values                         = [for key, resource_access in each.value.resource_access : key if resource_access.type == "Scope"]
}

resource "azuread_service_principal_delegated_permission_grant" "application_calling_downstream_apis_managed_resource" {
  for_each = {
    for key, item in local.api_permissions_enriched : key => item if var.grant_admin_consent && contains([for r in item.resource_access : r.type], "Scope") && item.is_managed_resource
  }

  service_principal_object_id          = azuread_service_principal.application.object_id
  resource_service_principal_object_id = each.value.managed_resource_serviceprincipal_object_id
  claim_values                         = [for key, resource_access in each.value.resource_access : key if resource_access.type == "Scope"]
}

# secret for AzureAD app
resource "azuread_application_password" "application" {
  count                 = var.secret_required ? 1 : 0
  application_object_id = azuread_application.application.object_id
  end_date              = var.secret_expiry_date == null ? time_offset.two_years.rfc3339 : replace(replace(var.secret_expiry_date, "\"", ""), "'", "")
  lifecycle {
    ignore_changes = [end_date]
  }
}

