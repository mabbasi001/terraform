variable "key_vault_id" {
  description = "The ID of the Key Vault where the Secret should be created."
  type        = string
}

variable "name" {
  description = "Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created."
  type        = string
}

variable "value" {
  description = "Specifies the value of the Key Vault Secret."
  type        = string
}

variable "content_type" {
  description = "Specifies the value of the Key Vault Secret."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the key vault secret."
  type        = map(string)
  default     = {}
}