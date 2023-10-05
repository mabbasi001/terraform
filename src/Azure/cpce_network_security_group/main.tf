locals {
  name = var.name != null ? var.name : lower(format("nsg%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))

  retention_in_days = var.disable_sa_diagnostic_retention_in_days ? 0 : var.retention_in_days
}

resource "azurerm_network_security_group" "cpce_network_security_group" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_monitor_diagnostic_setting" "cpce_nsg_diagnostic_setting" {
  count                      = var.log_analytics_workspace == null ? 0 : 1
  name                       = "to-LogAnalytics"
  target_resource_id         = azurerm_network_security_group.cpce_network_security_group.id
  log_analytics_workspace_id = var.log_analytics_workspace.id
  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
    retention_policy {
      days    = local.retention_in_days
      enabled = true
    }
  }
  enabled_log {
    category = "NetworkSecurityGroupEvent"
    retention_policy {
      days    = local.retention_in_days
      enabled = true
    }
  }
  depends_on = [
    azurerm_network_security_group.cpce_network_security_group
  ]
}
