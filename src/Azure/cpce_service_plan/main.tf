resource "azurerm_service_plan" "cpce_service_plan" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = azurecaf_name.name.result
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = merge({ managed_by_terraform = true }, var.tags)
}
