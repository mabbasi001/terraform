variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "quality" {
  description = "The quality level of the hub resources to be provisioned."
  type        = string
  default     = "DEV"
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.quality)
    error_message = "Quality must be one of 'DEV', 'TEST' or 'PROD'."
  }
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

variable "tenant_id" {
  description = "The ID of the Azure Active Directory tenant that should be used for authenticating requests to this resource"
  type        = string
}

variable "name" {
  description = "The name of the key vault"
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = false
}

variable "purge_protection_enabled" {
  description = "Purge Protection switch for this Key Vault."
  type        = bool
  default     = null
}

variable "soft_delete_retention_days" {
  description = "The number of days for which soft-deleted items should be retained."
  type        = number
  default     = null
}

variable "contacts" {
  description = "A map of contacts that should be notified of impending certificate expirations."
  type = map(object({
    name  = string
    email = string
    phone = string
  }))
  default = {}
  validation {
    condition     = alltrue([for contact in var.contacts : contact.name != null])
    error_message = "All certificate contacts must have a name."
  }
}
