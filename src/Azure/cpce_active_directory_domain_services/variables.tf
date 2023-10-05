variable "instance_code" {
  description = "A code for the instance of the front door that is being created (e.g. 'CPCE' or 'MS'). Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'TEST' or 'PROD'). Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource. Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure front door. Changing this forces the resource to be destroyed/recreated."
  type        = string
}

variable "name" {
  description = "The name of the resource. Changing this forces the resource to be destroyed/recreated."
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure Region in which the AADDS resource should be created. Changing this forces the resource to be destroyed/recreated."
  type        = string
}

variable "sku" {
  description = "The SKU for this AADDS instance. Possible values are 'Standard', 'Enterprise' & 'Premium'."
  type        = string
  default     = "Enterprise"
  validation {
    condition     = contains(["Standard", "Enterprise", "Premium"], var.sku)
    error_message = "Invalid AADDS Sku. Valid values are 'Standard', 'Enterprise' and 'Premium'."
  }
}

variable "domain_name" {
  description = <<-DESCRIPTION
    The Active Directory domain to be created in the Virtual Network.
    See https://docs.microsoft.com/en-gb/azure/active-directory-domain-services/tutorial-create-instance#create-a-managed-domain for constraints and recommendations.
  DESCRIPTION
  type        = string
}

variable "domain_configuration_type" {
  description = "The configuration type of this Active Directory Domain."
  type = string
  default = "FullySynced"
}

variable "subnet_id" {
  description = "Resource ID of the subnet into which the primary domain controller replica set will be deployed."
  type        = string
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "ldaps_certificate" {
  description = "The base64-encoded TripleDES-SHA1 encrypted PKCS#12 representation of the certificate used for secure LDAPS."
  type        = string
}

variable "ldaps_certificate_password" {
  description = "The password of the certificate used for secure LDAPS."
  type        = string
  sensitive   = true
}

variable "ldaps_enable" {
  description = "Whether to enable secure LDAP for the managed domain."
  type        = bool
  default     = true
}

variable "ldaps_external_access_enabled" {
  description = "Whether to enable secure LDAP for external access."
  type        = bool
  default     = false
}

variable "filtered_sync_enabled" {
  description = "Should filtered synchronisation be enabled? If enable, the specific groups to syncrhonise needs to be managed outside of Terraform."
  type        = bool
  default     = false
}

variable "kerberos_rc4_encryption_enabled" {
  description = "Whether to enable Kerberos RC4 Encryption."
  type = bool
  default = true
}
