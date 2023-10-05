variable "resource_group_name" {
  description = "The name of the resource group in which this virtual machine should exist."
  type        = string
}

variable "name" {
  description = "The name of the resource. If provided, this will override the auto-generated name."
  type        = string
  default     = null
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'TEST' or 'PROD'). Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource. Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "outbound_endpoint_ids" {
  description = "The list of outbound endpoint ids to associate to the ruleset."
  type        = list(string)
}

variable "virtual_network_id" {
  description = "The id of the virtual network to link to ruleset."
  type        = string
}

variable "generate_azurecaf_name" {
  description = "Determines whether the resource should use the AzureCAF name generation (true) or use the custom CPCE method (false)."
  type        = bool
  default     = false
}
