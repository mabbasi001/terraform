data "azurerm_client_config" "current" {}

locals {
  naming_seed = parseint(substr(data.azurerm_client_config.current.tenant_id, 0, 8), 16)
  
  suffixes = [var.location, var.environment_code, var.name_suffix]
  populated_suffixes = [for suffix in local.suffixes: suffix if suffix != null]
}

resource "azurecaf_name" "name" {
  name          = var.name
  resource_type = "azurerm_app_service"
  suffixes      = local.populated_suffixes
  random_seed   = local.naming_seed
  random_length = 4
  clean_input   = true
}