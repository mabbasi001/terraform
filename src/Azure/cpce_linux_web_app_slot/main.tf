resource "azurerm_linux_web_app_slot" "cpce_linux_web_app_slot" {
  name                      = var.name
  app_service_id            = var.app_service_id
  virtual_network_subnet_id = var.virtual_network_subnet_id
  https_only                = true

  tags = merge({ managed_by_terraform = true }, var.tags)

  site_config {
    http2_enabled            = true
    always_on                = true
    remote_debugging_enabled = false
    ftps_state               = "FtpsOnly"
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        action                    = ip_restriction.value.action
        headers                   = ip_restriction.value.headers
        ip_address                = ip_restriction.value.ip_address
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        service_tag               = ip_restriction.value.service_tag
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
      }
    }
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge({
    "ASPNETCORE_ENVIRONMENT"         = var.environment_code
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.application_insights_instrumentation_key
  }, var.app_settings)

  lifecycle {
    ignore_changes = []
  }
}
