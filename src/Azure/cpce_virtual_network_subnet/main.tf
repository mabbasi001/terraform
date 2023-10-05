locals {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  name                 = var.name != null ? var.name : lower("snet-${var.name_suffix}")
  service_endpoints    = var.service_endpoints
  delegation           = var.delegation
}

resource "azurerm_subnet" "cpce_virtual_network_subnet" {
  name                                           = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  
  resource_group_name                            = local.resource_group_name
  virtual_network_name                           = local.virtual_network_name
  address_prefixes                               = local.address_prefixes
  enforce_private_link_endpoint_network_policies = true # This allows private endpoints to be created within the subnet
  service_endpoints                              = local.service_endpoints
  dynamic "delegation" {
    for_each = local.delegation
    content {
      name = delegation.value.name
      service_delegation {
        actions = delegation.value.actions
        name    = delegation.value.service_name
      }
    }
  }
}

# TODO : this needs fixing at some point as TF complains about not knowing object id's before apply

/* resource "azurerm_subnet_network_security_group_association" "cpce_virtual_network_subnet_nsg" {
  count                     = local.nsg_id == null ? 0 : 1
  subnet_id                 = azurerm_subnet.cpce_virtual_network_subnet.id
  network_security_group_id = local.nsg_id
}

resource "azurerm_subnet_nat_gateway_association" "cpce_virtual_network_subnet_nat_gateway" {
  count          = local.nat_gateway_id == null ? 0 : 1
  subnet_id      = azurerm_subnet.cpce_virtual_network_subnet.id
  nat_gateway_id = local.nat_gateway_id
 }
resource "azurerm_subnet_route_table_association" "cpce_virtual_network_subnet_route_table" {
  count          = local.route_table_id == null ? 0 : 1
  subnet_id      = azurerm_subnet.cpce_virtual_network_subnet.id
  route_table_id = local.route_table_id
 } */
