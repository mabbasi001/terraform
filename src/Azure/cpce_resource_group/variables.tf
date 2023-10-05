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

variable "location" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}

variable "tags" {
  description = "A map of tags that should be assigned to the Resource Group."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "The Name which should be used for this resource it will override the concaternated one"
  type        = string
  default     = null
}
