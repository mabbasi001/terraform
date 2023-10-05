variable "alert_emails" {
  description = "The emails of users that should be informed when the web test fails. If no emails are set, the alert will not be created. If action_group_id provided then is not used"
  type        = set(string)
  default     = []
}

variable "action_group_id" {
  description = "The id of the action group to be used. If set overrides use of alert_emails"
  type        = string
  default     = null
}

variable "reference_action_group" {
  description = "Boolean to state that action group id will be referenced"
  type        = bool   
}

variable "alert_description" {
  description = "The description to be shown to alerted users when the web test fails"
  type        = string
  default     = ""
}

variable "application_insights_id" {
  description = "The id of the Application Insights resource associated to this web test"
  type        = string
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
  description = "The name for the resource"
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

variable "target_location" {
  description = "The location of the target resource under test - for use in differentiating tests in the same app insights"
  type        = string
  default     = null
}

variable "web_test_configuration" {
  description = "An XML configuration specification for a web test"
  type        = string
}

variable "web_test_geo_locations" {
  description = "The geographical locations that should be used to perform the web test"
  type        = set(string)
}