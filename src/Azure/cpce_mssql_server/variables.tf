variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
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

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Allowed values for environment_quality are \"DEV\", \"TEST\", or \"PROD\"."
  }
}

variable "name" {
  description = "The name of the sql server"
  type        = string
  default     = null
}

variable "admin_username" {
  description = "Username of the sql server of admin account."
  type        = string
  default     = "sqladmin"
}

variable "admin_password" {
  description = "The password associated with the sql server administrator account."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this server."
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The Minimum TLS Version."
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.2"], var.minimum_tls_version)
    error_message = "Only TLS 1.2 is currently supported.  1.0 and 1.1 are deprecated and support for 1.3 is to be added."
  }
}

variable "identity_type" {
  description = "Specifies the identity type of the Microsoft SQL Server. Possible values are SystemAssigned and UserAssigned where you can specify the Service Principal IDs in the user_assigned_identity_ids field."
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "Identity type must be either SystemAssigned or UserAssigned."
  }
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Identity IDs to be assigned. Required if identity_type is UserAssigned."
  type        = list(string)
  default     = null
}

variable "primary_user_assigned_identity_id" {
  description = "Specifies the primary user managed identity id. Required if type is UserAssigned and should be combined with user_assigned_identity_ids."
  type        = string
  default     = null
}

variable "aad_login_username" {
  description = "The login username of the Azure AD Administrator of this SQL Server."
  type        = string
  default     = null
}

variable "aad_login_object_id" {
  description = "The object id of the Azure AD Administrator of this SQL Server."
  type        = string
  default     = null
}

variable "aad_login_tenant_id" {
  description = "The tenant id of the Azure AD Administrator of this SQL Server."
  type        = string
  default     = null
}

variable "aad_auth_only" {
  description = "Specifies whether only AD Users and administrators can be used to login or also local database users."
  type        = bool
  default     = true
}
