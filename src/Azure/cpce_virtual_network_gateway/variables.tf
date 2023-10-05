variable "resource_group_name" {
  description = "The name of the resource group in which to create this resource."
  type        = string
}

variable "location" {
  description = "The region in which this resource should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for to which this resource belongs."
  type        = string
  default     = null
}

variable "environment_code" {
  description = "The code of the environment in which this resource should exist."
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}

variable "name" {
  description = "An override for the name of this resource. If supplied, customer_code, environment_code & name_suffix will be ignored."
  type        = string
  default     = null
}

variable "sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are 'ErGw1AZ', 'ErGw2AZ', 'ErGw3AZ', 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw4', 'VpnGw5', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3AZ', 'VpnGw4AZ' & 'VpnGw5AZ' and also depend on the type, vpn_type and generation arguments. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway."
  type        = string
  default     = "VpnGw1AZ"
}

variable "type" {
  description = "The type of the Virtual Network Gateway. Possible values are 'Vpn' or 'ExpressRoute'. Default's to 'Vpn'."
  type        = string
  default     = "Vpn"

  validation {
    condition     = contains(["ExpressRoute", "Vpn"], var.type)
    error_message = "Virtual Network Gateway type must be one of 'ExpressRoute' or 'Vpn'."
  }
}

variable "vpn_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are 'RouteBased' or 'PolicyBased'. Defaults to 'RouteBased'."
  type        = string
  default     = "RouteBased"

  validation {
    condition     = contains(["RouteBased", "PolicyBased"], var.vpn_type)
    error_message = "Virtual Network Gateway vpn_type must be one of 'RouteBased' or 'PolicyBased'."
  }
}

variable "ip_configuration" {
  description = "Details of the IP configuration of the Virtual Network Gateway (within its Virtual Network)."
  type = object({
    name                               = string
    subnet_id                          = string
    private_ip_address_allocation_type = string
    public_ip_address_id               = string
  })

  validation {
    condition     = var.ip_configuration.subnet_id != null
    error_message = "The subnet_id in which the Virtual Network Gateway should be created is mandatory."
  }
  validation {
    condition     = var.ip_configuration.private_ip_address_allocation_type == null ? true : contains(["Static", "Dynamic"], var.ip_configuration.private_ip_address_allocation_type)
    error_message = "If supplied, the private_ip_address_allocation_type must be either 'Static' or 'Dynamic'."
  }
  validation {
    condition     = var.ip_configuration.public_ip_address_id != null
    error_message = "The resourceID of the Public IP Address that the Virtual Network Gateway should use is mandatory."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
