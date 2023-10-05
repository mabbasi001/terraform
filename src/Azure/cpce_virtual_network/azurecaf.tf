data "azurerm_client_config" "current" {
  count = var.generate_azurecaf_name ? 1 : 0
}

locals {
  naming_seed     = var.generate_azurecaf_name ? parseint(substr(data.azurerm_client_config.current[0].tenant_id, 0, 8), 16) : 0
  
  suffixes = [var.location, var.environment_code, var.name_suffix]
  populated_suffixes = [for suffix in local.suffixes: suffix if suffix != null]
}

resource "azurecaf_name" "name" {  
  count = var.generate_azurecaf_name ? 1 : 0
  
  name              = var.name
  resource_type     = "azurerm_virtual_network"
  suffixes          = local.populated_suffixes
  random_seed       = local.naming_seed
  random_length     = 4
  clean_input       = true
}