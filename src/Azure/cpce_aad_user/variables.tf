variable "user_principal_name" {
  description = "The fully qualified domain name of the AAD user being created."
  type        = string
}

variable "display_name" {
  description = "The display name of the AAD user being created."
  type        = string
}

variable "password" {
  description = "The password used at creation for the AAD user being created."
  type        = string
  sensitive   = true
}
