variable "alert_emails" {
  description = "The emails of users that should be informed when the web test fails. If no emails are set, the alert will not be created"
  type        = set(string)
  default     = []
}

variable "ignore_email_changes" {
  description = "Boolean to enable editting of alert email group"
  type        = bool
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "name" {
  description = "The override name for the resource"
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}