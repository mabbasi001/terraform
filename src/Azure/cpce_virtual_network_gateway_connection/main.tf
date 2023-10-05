locals {
  vpn_connection_name = coalesce(var.name, lower(format("vcn%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
  local_network_gateway_name = coalesce(var.local_network_gateway_name, lower(format("lgw%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

module "shared_key" {
  source = "../../Random/cpce_random_password"
  count  = var.remote_network_gateway_shared_key == null ? 1 : 0
  # Note : This will only be used if the remote_network_gateway_shared_key variable is null
}

resource "azurerm_local_network_gateway" "onprem_network" {
  count               = var.remote_network_gateway_ip_address == null ? 0 : 1
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = local.local_network_gateway_name
  gateway_address     = var.remote_network_gateway_ip_address
  address_space       = var.remote_network_address_space
  tags                = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  resource_group_name             = var.resource_group_name
  location                        = var.location
  name                            = local.vpn_connection_name
  virtual_network_gateway_id      = var.virtual_network_gateway_id
  type                            = var.type
  local_network_gateway_id        = !contains(["ExpressRoute", "Vnet2Vnet"], var.type) ? azurerm_local_network_gateway.onprem_network[0].id : null
  peer_virtual_network_gateway_id = var.type == "Vnet2Vnet" ? var.peer_virtual_network_gateway_id : null
  shared_key                      = var.type != "ExpressRoute" ? (var.remote_network_gateway_shared_key != null ? var.remote_network_gateway_shared_key : module.shared_key[0].result) : null
  express_route_circuit_id        = var.type == "ExpressRoute" ? var.express_route_circuit_id : null
  authorization_key               = var.type == "ExpressRoute" ? var.express_route_authorization_key : null
  connection_protocol             = var.type == "IPSec" || var.type == "Vnet2Vnet" ? coalesce(var.connection_protocol, "IKEv2") : null
  enable_bgp                      = var.enable_bgp
  dpd_timeout_seconds             = var.dpd_timeout_seconds
  tags                            = merge({ managed_by_terraform = true }, var.tags)
  dynamic "ipsec_policy" {
    # use a dummy for_each block to conditionally create 0 or 1 of these
    for_each = var.ipsec_policy != null ? [1] : []
    content {
      dh_group         = coalesce(var.ipsec_policy.dh_group, "DHGroup14")
      ike_encryption   = coalesce(var.ipsec_policy.ike_encryption, "AES256")
      ike_integrity    = coalesce(var.ipsec_policy.ike_integrity, "SHA256")
      ipsec_encryption = coalesce(var.ipsec_policy.ipsec_encryption, "AES256")
      ipsec_integrity  = coalesce(var.ipsec_policy.ipsec_integrity, "SHA256")
      pfs_group        = coalesce(var.ipsec_policy.pfs_group, "PFS2048")
      sa_datasize      = var.ipsec_policy.sa_datasize
      sa_lifetime      = var.ipsec_policy.sa_lifetime
    }
  }
}
