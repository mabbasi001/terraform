# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be put."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

# Optional
variable "customer_code" {
  description = "The code of the customer for which this resource was created."
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")."
  type        = string
  default     = null
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Invalid environment_quality. Allowed values are \"DEV\", \"TEST\" and \"PROD\"."
  }
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource."
  type        = string
  default     = null
}

variable "name" {
  description = "The override name for the resource."
  type        = string
  default     = null
}

variable "sku" {
  description = "Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default     = "Standard"
  validation {
    condition     = var.sku == null ? true : contains(["Standard", "RS0"], var.sku)
    error_message = "Allowed values for sku are Standard and RS0."
  }
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}