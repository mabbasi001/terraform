variable "resource_group_name" {
  description = "The name of the resource group in which to create the public ip."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. "
  type        = string
}

variable "name" {
  description = "Specifies the name of the Public IP resource, it will override the auto-generated one."
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

variable "zones" {
  description = "A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [ "1", "2", "3" ]
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
  validation {
    condition     = var.sku == null ? true : contains(["Basic", "Standard"], var.sku)
    error_message = "Allowed values for sku are null (for the default), 'Basic' and 'Standard'."
  }
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address."
  type        = string
  default     = "Static"
  validation {
    condition     = var.allocation_method == null ? true : contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "Allowed values for allocation_method are null (for the default), 'Static' and 'Dynamic'."
  }
}

variable "tags" {
  description = "A map of tags that should be assigned to this resource."
  type        = map(string)
  default     = {}
}
