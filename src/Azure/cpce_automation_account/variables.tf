variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Allowed values for environment_quality are \"DEV\", \"TEST\", or \"PROD\"."
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

variable "sku_name" {
  description = "The Name of the SKU used for Automation Account. Possible value is Basic"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "managed_identity" {
  description = "Assign a Managed Identity to the resource."
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.managed_identity)
    error_message = "Allowed values for managed_identity are \"SystemAssigned\", \"UserAssigned\"."
  }
}


