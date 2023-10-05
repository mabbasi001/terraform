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

variable "subnet_id" {
  description = "(Optional) Frontend subnet id to use when in private mode"
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  type        = string
  default     = null
}

variable "private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
  validation {
    condition     = contains(["Dynamic", "Static"], var.private_ip_address_allocation)
    error_message = "Allowed values for loadbalancer types  are \"private\", \"public\"."
  }
}

variable "sku_name" {
  description = "(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.sku_name)
    error_message = "Allowed values for loadbalancer sku  \"Standard\", \"Basic\"."
  }
}

variable "nat_rules" {
  description = "Nat Rules to be used for remote vm access. [protocol, remote_port, backend_port]."
  type = map(object({
    protocol     = string
    remote_port  = number
    backend_port = number
  }))
  default = {}
}

variable "lb_rules" {
  description = "(Optional) Manages a Load Balancer Rule."
  type = map(object({
    frontend_port  = number
    backend_port   = number
    probe_port     = number
    probe_protocol = string
    request_path   = string
  }))
  default = {}
}

variable "zones" {
  description = "(Optional) Resource Availability Zone"
  type        = list(string)
  default     = [ "1", "2", "3" ]
}

variable "public_ip_address_id" {
  description = "The ID of a Public IP Address which should be associated with the Load Balancer"
  type = string
  default = null
}
