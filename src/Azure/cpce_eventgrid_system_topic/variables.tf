variable "resource_group_name" {
  description = "The name of the resource group in which to create the event grid topic. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
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

variable "storage_account_id" {
  description = "The name of the Storage account the topic will be assigned to"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "topic_type" {
  description = "The topic_type of the resource"
  type        = string
  default     = null
}
