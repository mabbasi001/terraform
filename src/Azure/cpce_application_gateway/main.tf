locals {
  name = var.name != null ? var.name : lower(format("agw%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : ""
  ))

  probe_names                           = { for key, val in var.probes : key => format("%s-probe-%s", local.name, key) }
  backend_address_pool_names            = { for key, val in var.backend_address_pools : key => format("%s-backend-address-pool-%s", local.name, key) }
  backend_http_setting_names            = { for key, val in var.backend_http_settings : key => format("%s-backend-http-setting-%s", local.name, key) }
  frontend_ip_configuration_names       = { for key, val in var.frontend_ip_configurations : key => format("%s-frontend-ip-configuration-%s", local.name, key) }
  frontend_port_names                   = { for key, val in var.frontend_ports : key => format("%s-frontend-port-%s", local.name, key) }
  gateway_ip_configuration_names        = { for key, val in var.gateway_ip_configurations : key => format("%s-gateway-ip-configuration-%s", local.name, key) }
  application_gateway_certificate_names = { for key, val in var.application_gateway_certificates : key => format("%s-application-gateway-certificate-%s", local.name, key) }
  http_listener_names                   = { for key, val in var.http_listeners : key => format("%s-http-listener-%s", local.name, key) }
  request_routing_rule_names            = { for key, val in var.request_routing_rules : key => format("%s-request-routing-rule-%s", local.name, key) }
  url_path_map_names                    = { for key, val in var.url_path_maps : key => format("%s-url-path-%s", local.name, key) }
}

data "azurerm_client_config" "current" {
}

resource "azurerm_public_ip" "cpce_application_gateway_public_ip" {
  name                = "pip-${local.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)
}

resource "azurerm_key_vault_certificate" "application_gateway_certificate" {
  for_each = var.application_gateway_certificates

  name         = local.application_gateway_certificate_names[each.key]
  key_vault_id = var.key_vault_id

  certificate {
    contents = filebase64(each.value.pfx_path)
    password = var.application_gateway_certificate_passwords[each.key]
  }

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }
    key_properties {
      exportable = true
      key_size   = each.value.key_size
      key_type   = each.value.key_type
      reuse_key  = false
    }
    lifetime_action {
      action {
        action_type = "EmailContacts"
      }
      trigger {
        days_before_expiry = var.application_gateway_certificate_notification_days_before_expiry
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    application_gateway  = local.name
    certificate_type     = each.value.type
    managed_by_terraform = true
  }, var.tags)
}

resource "azurerm_user_assigned_identity" "application_gateway_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "id-${local.name}"
  tags = merge({
    app_gateway          = local.name
    managed_by_terraform = true
  }, var.tags)
}

/*resource "azurerm_role_assignment" "application_gateway_user_assigned_identity_certificates_permissions" {
  for_each             = azurerm_key_vault_certificate.application_gateway_certificate
  scope                = "${var.key_vault_id}/certificates/${azurerm_key_vault_certificate.application_gateway_certificate[each.key].name}"
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = azurerm_user_assigned_identity.application_gateway_identity.principal_id
}*/

resource "azurerm_role_assignment" "application_gateway_user_assigned_identity_secrets_permissions" {
  for_each             = azurerm_key_vault_certificate.application_gateway_certificate
  scope                = "${var.key_vault_id}/secrets/${azurerm_key_vault_certificate.application_gateway_certificate[each.key].name}"
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.application_gateway_identity.principal_id
}

resource "azurerm_application_gateway" "cpce_app_gateway" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  enable_http2        = true

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.application_gateway_identity.id]
  }

  sku {
    name     = var.application_gateway_sku
    tier     = var.application_gateway_tier
    capacity = var.application_gateway_capacity
  }

  waf_configuration {
    enabled          = var.waf_enabled
    firewall_mode    = var.firewall_mode
    rule_set_type    = var.rule_set_type
    rule_set_version = var.rule_set_version
  }

  dynamic "ssl_certificate" {
    for_each = var.application_gateway_certificates
    content {
      name                = local.application_gateway_certificate_names[ssl_certificate.key]
      key_vault_secret_id = azurerm_key_vault_certificate.application_gateway_certificate[ssl_certificate.key].secret_id
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configurations

    content {
      name      = local.gateway_ip_configuration_names[gateway_ip_configuration.key]
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports

    content {
      name = local.frontend_port_names[frontend_port.key]
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations

    content {
      name                          = local.frontend_ip_configuration_names[frontend_ip_configuration.key]
      subnet_id                     = frontend_ip_configuration.value.subnet_id
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
      public_ip_address_id          = azurerm_public_ip.cpce_application_gateway_public_ip.id
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools

    content {
      name         = local.backend_address_pool_names[backend_address_pool.key]
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "probe" {
    for_each = var.probes

    content {
      host                                      = probe.value.host
      interval                                  = probe.value.interval
      name                                      = local.probe_names[probe.key]
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      port                                      = probe.value.port
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      minimum_servers                           = probe.value.minimum_servers

      dynamic "match" {
        for_each = probe.value.match == null ? [] : [1]

        content {
          body        = probe.value.match.body
          status_code = probe.value.match.status_code
        }
      }
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings

    content {
      name                                = local.backend_http_setting_names[backend_http_settings.key]
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      path                                = backend_http_settings.value.path
      port                                = backend_http_settings.value.port
      probe_name                          = backend_http_settings.value.probe_key == null ? null : local.probe_names[backend_http_settings.value.probe_key]
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      host_name                           = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names

      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value.authentication_certificate_names

        content {
          name = authentication_certificate.value
        }
      }

      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining == null ? [] : [1]

        content {
          enabled           = backend_http_settings.value.connection_draining.enabled
          drain_timeout_sec = backend_http_settings.value.connection_draining.drain_timeout_sec
        }
      }
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_maps

    content {
      name                               = local.url_path_map_names[url_path_map.key]
      default_backend_address_pool_name  = local.backend_address_pool_names[url_path_map.value.default_backend_address_pool_key]
      default_backend_http_settings_name = local.backend_http_setting_names[url_path_map.value.default_backend_http_setting_key]

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules

        content {
          name                       = format("%s-path-rule-%s", local.name, path_rule.key)
          paths                      = path_rule.value.paths
          backend_address_pool_name  = local.backend_address_pool_names[path_rule.value.backend_address_pool_key]
          backend_http_settings_name = local.backend_http_setting_names[path_rule.value.backend_http_setting_key]
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners

    content {
      name                           = local.http_listener_names[http_listener.key]
      frontend_ip_configuration_name = local.frontend_ip_configuration_names[http_listener.value.frontend_ip_configuration_key]
      frontend_port_name             = local.frontend_port_names[http_listener.value.frontend_port_key]
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = local.application_gateway_certificate_names[http_listener.value.ssl_certificate_key]
      host_name                      = http_listener.value.host_name
      host_names                     = http_listener.value.host_names
      require_sni                    = http_listener.value.require_sni
      firewall_policy_id             = http_listener.value.firewall_policy_id

      dynamic "custom_error_configuration" {
        for_each = http_listener.value.custom_error_configurations

        content {
          status_code           = custom_error_configuration.value.status_code
          custom_error_page_url = custom_error_configuration.value.custom_error_page_url
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules

    content {
      name                        = local.request_routing_rule_names[request_routing_rule.key]
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = local.http_listener_names[request_routing_rule.value.http_listener_key]
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_key == null ? null : local.backend_address_pool_names[request_routing_rule.value.backend_address_pool_key]
      backend_http_settings_name  = request_routing_rule.value.backend_http_setting_key == null ? null : local.backend_http_setting_names[request_routing_rule.value.backend_http_setting_key]
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name           = local.url_path_map_names[request_routing_rule.value.url_path_map_key]
    }
  }

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    application_gateway  = local.name
    managed_by_terraform = true
  }, var.tags)

  lifecycle {
    ignore_changes = [
      probe,
      backend_http_settings,
      url_path_map
    ]
  }

  depends_on = [
    #azurerm_role_assignment.application_gateway_user_assigned_identity_certificates_permissions,
    azurerm_role_assignment.application_gateway_user_assigned_identity_secrets_permissions
  ]
}