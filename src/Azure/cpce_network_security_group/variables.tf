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

variable "log_analytics_workspace" {
  description = "An object containing details of the log analytics workspace to which this NSG should report its diagnostic info."
  type        = object({ id = string })
  default     = null
}

variable "disable_sa_diagnostic_retention_in_days" {
  description = "Flag to disable usage of storage account retention in days - required for new diagnostic settings due to MS phased deprecation of legacy retention model."
  type        = bool
  default     = false
}

variable "retention_in_days" {
  description = "The number of days to retain data - ONLY applicable to LAWs backed by SA"
  type        = number
  default     = 90
}
