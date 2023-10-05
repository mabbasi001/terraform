resource "azurecaf_name" "name" {
  name          = var.name
  resource_type = "azurerm_app_service"
  suffixes      = [var.location, var.environment_code, var.name_suffix]
  random_length = 4
  clean_input   = true
}

resource "azurerm_static_site" "cpce_static_site" {
  name                = azurecaf_name.name.result
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_size            = "Standard"
  sku_tier            = "Standard"

  identity {
    type = "SystemAssigned"
  }
}
