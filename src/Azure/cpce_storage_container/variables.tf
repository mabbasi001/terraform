# Mandatory
variable "storage_account_name" {
  description = "The storage account in which the resource should exist"
  type        = string
}

# Mandatory
variable "name" {
  description = "The base name for the resource"
  type        = string
}

#Optional
variable "container_access_type" {
  description = "The access type for the container (e.g. \"blob\", \"container\" or \"private\")"
  type        = string
  default     = "private"
  validation {
    condition     = contains(["blob", "container", "private"], var.container_access_type)
    error_message = "Invalid environment quality specified. Must be one of the following: blob, container or private."
  }
}