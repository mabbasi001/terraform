locals {
  name = coalesce(var.name, lower(format("appi%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}
locals {
  default_daily_data_cap_in_gb = { DEV = 100, TEST = 100, PROD = null }
  default_retention_in_days    = { DEV = 30, TEST = 90, PROD = 90 }
  default_sampling_percentage  = { DEV = 100, TEST = 33, PROD = 10 }
  default_application_type     = "web"
}

resource "azurerm_application_insights" "cpce_application_insights" {
  name                                  = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  application_type                      = coalesce(var.application_type, local.default_application_type)
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb != null ? var.daily_data_cap_in_gb : local.default_daily_data_cap_in_gb[var.quality] # can't use coalesce here because the default value could also be null
  daily_data_cap_notifications_disabled = false
  retention_in_days                     = coalesce(var.retention_in_days, local.default_retention_in_days[var.quality])
  sampling_percentage                   = coalesce(var.sampling_percentage, local.default_sampling_percentage[var.quality])
  disable_ip_masking                    = false
  workspace_id                          = var.workspace_id
  tags                                  = merge({ managed_by_terraform = true }, var.tags)
}