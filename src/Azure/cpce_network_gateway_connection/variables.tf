variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}

variable "name" {
  description = "The override name for the resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "type" {
  description = "(Required) The type of connection. Valid options are IPsec, ExpressRoute or Vnet2Vnet."
  type        = string
  default     = "IPsec"
  validation {
    condition     = contains(["IPsec", "ExpressRoute"], var.type)
    error_message = "Allowed values for Azure NAT Gateway \"IPsec\", \"ExpressRoute\"."
  }
}

variable "connection_protocol" {
  description = "The IKE protocol version to use. Possible values are IKEv1 and IKEv2"
  type        = string
  default     = "IKEv2"
  validation {
    condition     = contains(["IKEv1", "IKEv2"], var.connection_protocol)
    error_message = "Allowed values for Azure NAT Gateway \"IKEv1\", \"IKEv2\"."
  }
}

variable "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit when creating an ExpressRoute connection"
  type        = string
  default     = null
}

variable "authorization_key" {
  description = "(Optional) The authorization key associated with the Express Route Circuit."
  type        = string
  sensitive   = true
  default     = null
}

variable "dpd_timeout_seconds" {
  description = "(Optional) The dead peer detection timeout of this connection in seconds."
  type        = number
  default     = 45
}

variable "enable_bgp" {
  description = "(Optional) If true, BGP (Border Gateway Protocol) is enabled for this connection. Defaults to false"
  type        = string
  default     = false
}

variable "virtual_network_gateway_id" {
  description = "Resource ID of the VPN Gateway"
  type        = string
  default     = null
}

variable "local_networks" {
  description = "List of local virtual network connections to connect to gateway."
  type = object({
    name            = string,
    gateway_address = string,
    address_space   = list(string)
  })
  default = null
}

variable "shared_key" {
  description = "The key to access to connect to gateways."
  type        = string
  default     = null
  sensitive   = true
}