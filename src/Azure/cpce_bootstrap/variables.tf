

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = "bootstrap"
}
variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = "ops"
}
variable "location" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
  default = "West Europe"
}

variable "tags" {
  description = "A map of tags that should be assigned to the Resource Group."
  type        = map(string)
  default     = {
    terraform = "local"
  }
}