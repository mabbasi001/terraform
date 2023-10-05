variable "secret_value" {
  description = <<EOT
    Secret value -
    If provided, a secret \"resource\" will be created by this terraform, and the value of such resource will not be updated other than the initial creation.
    If not provided, the encryption will be based on the secret retrieved from the \"data source\" where secret name = var.secret_name
    EOT
  type        = string
  default     = null
}

variable "secret_name" {
  description = "secret name in keyvault."
  type        = string
  validation {
    condition     = length(var.secret_name) <= 85
    error_message = "Max length of the secret name provided is 91 char to allow creation of encrypted secret with version suffix"
  }
}

variable "secret_is_managed_resource" {
  description = "when set to true, secret will be managed by this terraform as a resource"
  type        = bool
  default     = true
}

variable "environment_keyvault" {
  description = "key vault name"
  type        = string
}

variable "environment_keyvault_resource_group" {
  description = "key vault resource group"
  type        = string
}

variable "encryption_type" {
  description = "How we want to encrypt the secret, allowed options are \"none\", \"encipherment_certificate\", \"environment_manager\"."
  type        = string
  validation {
    condition     = contains(["none", "encipherment_certificate", "environment_manager"], var.encryption_type)
    error_message = "Allowed options are \"none\", \"encipherment_certificate\", \"environment_manager\"."
  }
}

variable "cpcedataenciphermentcertificatepath" {
  description = "secure_file_path"
  type        = string
  default     = null

  validation {
    condition     = var.cpcedataenciphermentcertificatepath == null ? true : fileexists(var.cpcedataenciphermentcertificatepath)
    error_message = "Encipherment certificate does not exist."
  }
}

variable "certificate_thumbprint" {
  description = "thumbprint of encipherment certificate"
  type        = string
  default     = null
}
