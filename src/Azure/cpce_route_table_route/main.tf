resource "azurerm_route" "cpce_route" {
  name                   = var.route.name
  resource_group_name    = var.resource_group_name
  route_table_name       = var.route.route_table_name
  address_prefix         = var.route.address_prefix
  next_hop_type          = var.route.next_hop_type
  next_hop_in_ip_address = var.route.next_hop_in_ip_address
}