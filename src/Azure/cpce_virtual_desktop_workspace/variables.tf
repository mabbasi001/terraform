variable "resource_group_name" {
  description = "The name of the resource group in which this virtual machine should exist."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "name" {
  description = "The name of the resource, by default it uses a collection of name,customer code, enviroment code and name sufix to populate the name. But you can override if needed to change the overall name"
  type        = string
  default     = null
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')"
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of both the resource and host"
  type        = string
  default     = null
  validation {
    # This is a maximum of 9 characters because it will be used to generate the host name, which has a maximum of 15 characters. 6 will have been used by the customer and environment codes, leaving 9 available here.
    # The allowed character set is slightly more restrictive than Azure allows. See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.name_suffix == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{1,7})([A-Za-z0-9])$", var.name_suffix)))
    error_message = "Invalid name_suffix. Using this value would result in the generation of an invalid virtual machine host name."
  }
}

variable "description" {
  description = "(Optional) A description for the Virtual Desktop Host Pool."
  type        = string
  default     = null
}

variable "friendly_name" {
  description = "A friendly name for the Virtual Desktop Workspace."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
