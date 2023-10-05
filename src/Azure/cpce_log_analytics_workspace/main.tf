locals {
  name = var.name != null ? var.name : lower(format("log%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))

  default_daily_quota_in_gb = {
    DEV  = 1,
    TEST = 2,
    PROD = 10
  }
}

resource "azurerm_log_analytics_workspace" "cpce_log_analytics_workspace" {
  name                = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  daily_quota_gb      = coalesce(var.daily_quota_gb, local.default_daily_quota_in_gb[var.environment_quality])
  sku                 = var.sku
  tags                = merge({ managed_by_terraform = true }, var.tags)
}
