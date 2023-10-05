
resource "azurerm_route_table" "cpce_route_table" {
  name                          = var.route_table.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.route_table.disable_bgp_route_propagation

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)
}