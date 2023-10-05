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

# Mandatory
variable "storage_quota" {
  description = "The quota for the storage file share"
  type        = number
  default     = 50
}