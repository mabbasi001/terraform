variable "name" {
  description = "The base name for the resource"
  type        = string
}

variable "skip_caf_name_generation" {
  description = "Should CAF naming be skipped for resource?"
  type        = bool
  default     = false
}

variable "resource_group" {
  description = "The name of the resource group in which to create the container registry. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID where to store registered AAD application password"
  type        = string
}
