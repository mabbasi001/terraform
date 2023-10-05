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

variable "group_type" {
  description = "The group_type is to show if it's either a app or desktop group"
  type        = string
  default     = null
}

variable "type" {
  description = "(Required) Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop application groups."
  type        = string
  default     = null
}

variable "host_pool_id" {
  description = "(Required) Resource ID for a Virtual Desktop Host Pool to associate with the Virtual Desktop Application Group."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A description for the Virtual Desktop Host Pool."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
