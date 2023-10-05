# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "address_space" {
  description = "The address space to be allocated to the virtual network, as CIDR string"
  type        = list(string)
  validation {
    condition     = alltrue([for space in var.address_space : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", space))])
    error_message = "All address spaces must be supplied in CIDR format."
  }
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

variable "generate_azurecaf_name" {
  description = "Determines whether the resource should use the AzureCAF name generation (true) or use the custom CPCE method (false)."
  type        = bool
  default     = false
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

variable "dns_servers" {
  description = "The override name for the resource"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
