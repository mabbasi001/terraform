data "azurerm_client_config" "current" {}

locals {
  naming_seed        = parseint(substr(data.azurerm_client_config.current.tenant_id, 0, 8), 16)
  suffixes           = [var.target_location, var.environment_code, var.name_suffix]
  populated_suffixes = [for suffix in local.suffixes: suffix if suffix != null]
}

resource "azurecaf_name" "azurerm_application_insights_web_test" {
  name          = var.name
  resource_type = "azurerm_application_insights_web_test"
  suffixes      = local.populated_suffixes
  random_seed   = local.naming_seed
  random_length = 4
  clean_input   = true
}

resource "azurecaf_name" "azurerm_monitor_action_group" {
  count = local.should_create_action_group ? 1 : 0

  name          = var.name
  resource_type = "azurerm_monitor_action_group"
  suffixes      = local.populated_suffixes
  random_seed   = local.naming_seed
  random_length = 4
  clean_input   = true
}

resource "azurecaf_name" "azurerm_monitor_metric_alert" {
  count = local.should_create_metric_alert ? 1 : 0

  name          = var.name
  resource_type = "azurerm_monitor_metric_alert"
  suffixes      = local.populated_suffixes
  random_seed   = local.naming_seed
  random_length = 4
  clean_input   = true
}