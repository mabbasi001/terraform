variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "quality" {
  type        = string
  description = "The quality of the resource being created. Must be one of the following: DEV, TEST or PROD."
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.quality)
    error_message = "Invalid environment quality specified. Must be one of the following: DEV, TEST or PROD."
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

variable "sampling_percentage" {
  description = "The percentage of the data produced by the monitored application that is sampled for Application Insights telemetry"
  type        = number
  default     = null
  validation {
    condition     = var.sampling_percentage == null ? true : (var.sampling_percentage >= 0) && (var.sampling_percentage <= 100)
    error_message = "Application Insights sampling_percentage must either be null (for the default value) or between 0 and 100."
  }
}

variable "daily_data_cap_in_gb" {
  description = "The maximum number of gigabytes of data that can be send to this application insights resource."
  type        = number
  default     = null
}

variable "retention_in_days" {
  description = "The retention period in days of telemetry in Application Insights. Possible values are null (for the default), 30, 60, 90, 120, 180, 270, 365, 550 or 730."
  type        = number
  default     = null
  validation {
    condition     = var.retention_in_days == null ? true : contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "Application Insights retention_in_days must either be null (for the default value) or one of the following: 30, 60, 90, 120, 180, 270, 365, 550 or 730."
  }
}

variable "workspace_id" {
  description = "Specifies the id of a log analytics workspace resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "application_type" {
  type    = string
  default = null
  validation {
    condition     = var.application_type == null ? true : contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = "Application Insights application_type must either be null (for the default value) or one of the following: ios, java, MobileCenter, Node.JS, other, phone, store, web."
  }
}
