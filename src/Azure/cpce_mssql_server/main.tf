locals {
  name = var.name != null ? var.name : lower(format("sql%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
  version = "12.0"
}

resource "azurerm_mssql_server" "cpce_sql_server" {
  resource_group_name               = var.resource_group_name
  location                          = var.location
  name                              = local.name
  version                           = local.version
  administrator_login               = var.admin_username
  administrator_login_password      = var.admin_password
  public_network_access_enabled     = var.public_network_access_enabled
  minimum_tls_version               = var.minimum_tls_version
  primary_user_assigned_identity_id = var.primary_user_assigned_identity_id
  tags                              = merge({ managed_by_terraform = true }, var.tags)

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  azuread_administrator {
    login_username              = var.aad_login_username
    object_id                   = var.aad_login_object_id
    tenant_id                   = var.aad_login_tenant_id
    azuread_authentication_only = var.aad_auth_only
  }
}
