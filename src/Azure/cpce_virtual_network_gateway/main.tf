locals {
  name = coalesce(var.name, lower(format("vgw%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))

  ip_configuration_name = coalesce(var.ip_configuration.name, lower(format("vgw-ipconfiguration%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

resource "azurerm_virtual_network_gateway" "vnet_gateway" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = local.name
  type                = var.type
  vpn_type            = var.vpn_type
  enable_bgp          = false
  sku                 = coalesce(var.sku, "VpnGw1AZ")

  ip_configuration {
    name                          = local.ip_configuration_name
    subnet_id                     = var.ip_configuration.subnet_id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation_type
    public_ip_address_id          = var.ip_configuration.public_ip_address_id
  }

  tags = merge({ managed_by_terraform = true }, var.tags)
}