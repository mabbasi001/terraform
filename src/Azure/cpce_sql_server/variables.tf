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

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Allowed values for environment_quality are \"DEV\", \"TEST\", or \"PROD\"."
  }
}

variable "name" {
  description = "The name of the sql server"
  type        = string
  default     = null
}

variable "admin_username" {
  description = "Username of the sql server of admin account."
  type        = string
  default     = "sqladmin"
}

variable "admin_password" {
  description = "The password associated with the sql server administrator account."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}