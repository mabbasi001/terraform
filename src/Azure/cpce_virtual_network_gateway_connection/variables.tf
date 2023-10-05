variable "resource_group_name" {
  description = "The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The region in which the resource should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "The code of the environment in which this VNET Gateway Connection should exist."
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}

variable "name" {
  description = "An override for the name of the Virtual Network Gateway Connection resource."
  type        = string
  default     = null
}

variable "local_network_gateway_name" {
  description = "An override name for the name of the Local Network Gateway resource."
  type        = string
  default     = null
}

variable "virtual_network_gateway_id" {
  description = "Resource ID of the Virtual Network Gateway resource in which to create this connection."
  type        = string
}

variable "type" {
  description = "The type of connection to be created. Valid options are 'IPsec' or 'ExpressRoute'."
  type        = string
  default     = "IPsec"
  validation {
    condition     = contains(["IPsec", "ExpressRoute", "Vnet2Vnet"], var.type)
    error_message = "Virtual Network Gateway Connection types must be one of 'IPsec', 'ExpressRoute' or 'Vnet2Vnet'."
  }
}

variable "remote_network_gateway_ip_address" {
  description = "IP address of the gateway in the remote network to which this connection is being made."
  type        = string
  default     = null
}

variable "remote_network_gateway_shared_key" {
  description = "The pre-shared key to be used for encrypting traffic over the VPN connection. If not supplied, one will be generated."
  type        = string
  default     = null
}

variable "peer_virtual_network_gateway_id" {
  description = "The ID of the peer virtual network gateway when creating a VNet-to-VNet connection."
  type        = string
  default     = null
}

variable "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit when creating an ExpressRoute connection"
  type        = string
  default     = null
}

variable "express_route_authorization_key" {
  description = "The authorization key associated with the Express Route Circuit."
  type        = string
  sensitive   = true
  default     = null
}

variable "remote_network_address_space" {
  description = "The address ranges of the remote network to be exposed by this Connection (in CIDR format)."
  type        = list(string)
  default     = null
}

variable "connection_protocol" {
  description = "The IKE protocol version to use. Possible values are 'IKEv1' and 'IKEv2'."
  type        = string
  default     = "IKEv2"
  validation {
    condition     = var.connection_protocol == null ? true : contains(["IKEv1", "IKEv2"], var.connection_protocol)
    error_message = "Allowed values for Azure NAT Gateway are null, 'IKEv1', 'IKEv2'."
  }
}

variable "dpd_timeout_seconds" {
  description = "The dead peer detection timeout of this connection in seconds."
  type        = number
  default     = 45
}

variable "enable_bgp" {
  description = "Whether Border Gateway Protocol is enabled for this VPN connection."
  type        = string
  default     = false
}

variable "ipsec_policy" {
  description = "The policy to apply to the IPSec connection"
  type = object({
    dh_group         = string
    ike_encryption   = string
    ike_integrity    = string
    ipsec_encryption = string
    ipsec_integrity  = string
    pfs_group        = string
    sa_datasize      = number
    sa_lifetime      = number
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}