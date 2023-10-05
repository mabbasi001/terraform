variable "resource_group_name" {
  description = "The name of the resource group in which this resource should exist."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')"
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of both the resource and host"
  type        = string
  default     = null
  validation {
    # This is a maximum of 9 characters because it will be used to generate the host name, which has a maximum of 15 characters. 6 will have been used by the customer and environment codes, leaving 9 available here.
    # The allowed character set is slightly more restrictive than Azure allows. See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.name_suffix == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{1,7})([A-Za-z0-9])$", var.name_suffix)))
    error_message = "Invalid name_suffix. Using this value would result in the generation of an invalid resource host name."
  }
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Invalid environment_quality. Allowed values are 'DEV', 'TEST' and 'PROD'."
  }
}

variable "name" {
  description = "The name of the apim resource. If provided, this will override the auto-generated name."
  type        = string
  default     = null
}

variable "sku_name" {
  type        = string
  description = "String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity"
  default     = "GP_Gen5"
}

variable "storage_size_in_gb" {
  type        = number
  description = "Maximum storage space for your instance. It should be a multiple of 32GB."
  default     = 32

  validation {
    condition     = (var.storage_size_in_gb % 32 == 0)
    error_message = "The storage size must be a multiple of 32."
  }
}

variable "vcores" {
  type        = number
  description = "Number of cores that should be assigned to your instance."
  default     = 4
}

variable "administrator_login" {
  description = "Username of the local admin user account."
  type        = string
  default     = "sqladmin"
}

variable "administrator_login_password" {
  description = "The password associated with the local administrator account."
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate this Managed Instance to."
  default     = null
}

variable "aad_admin_object_id" {
  description = "Object ID of identity of AAD admin."
  type        = string
  default     = null
}

variable "aad_admin_identity_name" {
  description = "Name of the identity of AAD amin."
  type        = string
  default     = null
}

variable "proxy_override" {
  description = "pecifies how the SQL Managed Instance will be accessed."
  type        = string
  default     = "Proxy"
  validation {
    condition     = contains(["Default", "Proxy", "Redirect"], var.proxy_override)
    error_message = "Invalid proxy_override. Allowed values are 'Default', 'Proxy' and 'Redirect'."
  }
}

variable "minimum_tls_version" {
  description = "The Minimum TLS Version."
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.2"], var.minimum_tls_version)
    error_message = "Only TLS 1.2 is currently supported.  1.0 and 1.1 are deprecated and supported for 1.3. is to be added."
  }
}

variable "license_type" {
  description = "What type of license the Managed Instance will use."
  type        = string
  default     = "LicenseIncluded"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "Invalid license_type. Allowed values are 'LicenseIncluded' and 'BasePrice'."
  }
}

variable "collation" {
  description = "Specifies how the SQL Managed Instance will be collated."
  type        = string
  default     = "Latin1_General_CI_AS"
}

variable "azuread_authentication_only" {
  description = "Specifies whether only AD Users and administrators can be used to login (true) or also local database users (false)."
  type        = bool
  default     = false
}

variable "timezone_id" {
  description = "The TimeZone ID that the SQL Managed Instance will be operating in."
  type        = string
  default     = "UTC"
}

variable "dns_zone_partner_id" {
  description = "The ID of the Managed Instance which will share the DNS zone. This is a prerequisite for creating a azurerm_sql_managed_instance_failover_group."
  type        = string
  default     = null
}