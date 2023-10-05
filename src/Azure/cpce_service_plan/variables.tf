# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be associated with"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
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
  description = "The base name for the resource"
  type        = string
  default     = null
}

variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan."
  type        = string
  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"], var.os_type)
    error_message = "Allowed values for os_type are Windows, Linux and WindowsContainer."
  }
}

variable "sku_name" {
  description = "The SKU for the plan."
  type        = string
  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P0v3", "P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3", "Y1"], var.sku_name)
    error_message = "Allowed values for sku name are B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P0v3, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  }
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

