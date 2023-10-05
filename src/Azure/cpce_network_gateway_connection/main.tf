locals {
  local_gw_name = var.name != null ? var.name : lower(format("lgw%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
  vpn_connection_name = var.name != null ? var.name : lower(format("vcn%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_local_network_gateway" "cpce_local_network_gateway" {
  count               = var.local_networks == null ? 0 : 1
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = lower(format("%s-%s", local.local_gw_name, var.local_networks.name))
  gateway_address     = var.local_networks.gateway_address
  address_space       = var.local_networks.address_space
  tags                = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_virtual_network_gateway_connection" "cpce_network_gateway_connection" {
  count                      = var.type == "ExpressRoute" ? 1 : 0
  name                       = lower(format("%s-%s", local.vpn_connection_name, var.local_networks.name))
  location                   = var.location
  resource_group_name        = var.resource_group_name
  type                       = var.type
  enable_bgp                 = var.enable_bgp
  dpd_timeout_seconds        = var.dpd_timeout_seconds
  connection_protocol        = var.type == "IPSec" ? var.connection_protocol : null
  virtual_network_gateway_id = var.virtual_network_gateway_id
  express_route_circuit_id   = var.type == "ExpressRoute" ? var.express_route_circuit_id : null
  local_network_gateway_id   = var.type != "ExpressRoute" ? azurerm_local_network_gateway.cpce_local_network_gateway[count.index].id : null
  shared_key                 = var.type != "ExpressRoute" ? var.shared_key : null
  authorization_key          = var.type == "ExpressRoute" ? var.authorization_key : null
  tags                       = merge({ managed_by_terraform = true }, var.tags)
}
