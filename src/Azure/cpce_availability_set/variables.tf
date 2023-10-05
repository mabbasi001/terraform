
variable "resource_group_name" {
  description = "The name of the Resource Group in which the Windows Virtual Machine Scale Set should be exist."
  type        = string
}

variable "location" {
  description = "The Azure location where the Windows Virtual Machine Scale Set should exist."
  type        = string
}

variable "name" {
  description = "The Name which should be used for this resource, it will override the auto-generated name one."
  type        = string
  default     = null
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

variable "fault_domain_count" {
  description = "The number of fault domains across which the VMs should be distributed."
  type        = number
  default     = 2
}

variable "update_domain_count" {
  description = "The number of update domains across which the VMs should be distributed."
  type        = number
  default     = 5
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}