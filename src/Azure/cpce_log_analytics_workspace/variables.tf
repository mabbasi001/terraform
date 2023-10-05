# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

# Optional
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

variable "sku" {
  description = "The SKU of the Log Analytics Workspace."
  type        = string
  default     = "PerGB2018"
  validation {
    condition     = contains(["Free", "PerNode", "Premium", "Standard", "Standalone", "Unlimited", "CapacityReservation", "PerGB2018"], var.sku)
    error_message = "Allowed values for sku are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation and PerGB2018."
  }
}

variable "environment_quality" {
  type        = string
  description = "The quality of the resource being created. Must be one of the following: DEV, TEST or PROD."
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Invalid environment quality specified. Must be one of the following: DEV, TEST or PROD."
  }
}

variable "daily_quota_gb" {
  description = "The workspace daily quota for ingestion in GB."
  type        = number
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}