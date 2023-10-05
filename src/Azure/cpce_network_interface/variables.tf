
variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Network Interface."
  type        = string
}

variable "location" {
  description = "The location where the Network Interface should exist."
  type        = string
}

variable "name" {
  description = "The name of the Network Interface, it will override the auto-generated one."
  type        = string
  default     = null
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

variable "subnet_id" {
  description = "The ID of the Subnet where this Network Interface should be located in."
  type        = string
}

variable "private_ip_address_allocation" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  type        = string
  default     = "Dynamic"

  validation {
    condition     = contains(["Dynamic", "Static"], var.private_ip_address_allocation)
    error_message = "Invalid private_ip_address_allocation. Allowed values are \"Dynamic\" and \"Static\"."
  }
}

variable "private_ip_address" {
  description = "The Static IP Address which should be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}