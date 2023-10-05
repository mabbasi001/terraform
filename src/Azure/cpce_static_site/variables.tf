# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

# Mandatory
variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

# Optional
variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}

# Optional
variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}

# Optional
variable "name" {
  description = "The base name for the resource"
  type        = string
  default     = null
}

# Optional
variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}