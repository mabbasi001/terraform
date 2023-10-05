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

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "server_id" {
  description = "The id of the MS SQL Server on which to create the database."
  type        = string
  default     = null
}

variable "collation" {
  description = "Specifies the collation of the database. Changing this forces a new resource to be created."
  type        = string
  default     = "Latin1_General_CI_AS"
}

variable "license_type" {
  description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  type        = string
  default     = "LicenseIncluded"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "Accepted values are LicenseIncluded or BasePrice."
  }
}

variable "max_size_gb" {
  description = "The max size of the database in gigabytes."
  type        = number
  default     = null
}

variable "read_scale" {
  description = "If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "Specifies the name of the SKU used by the database."
  type        = string
  default     = false
}

variable "zone_redundant" {
  description = "Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones."
  type        = bool
  default     = false
}

variable "elastic_pool_id" {
  description = "Specifies the ID of the elastic pool containing this database."
  type        = string
  default     = null
}

variable "threat_detection_policy" {
  description = "Threat detection policy configuration."
  type = map(object({
    state                      = bool
    disabled_alerts            = string
    email_account_admins       = string
    email_addresses            = list(string)
    retention_days             = number
    storage_account_access_key = string
    storage_endpoint           = string
  }))
  default = null
}

variable "long_term_retention_policy" {
  description = "Details of the (optional) long term retention policy."
  type = map(object({
    weekly_retention  = bool
    monthly_retention = string
    yearly_retention  = string
    week_of_year      = number
  }))
  default = null
}

variable "short_term_retention_policy" {
  description = "Details of the (optional) short term retention policy."
  type = map(object({
    retention_days = number
  }))
  default = null
}

