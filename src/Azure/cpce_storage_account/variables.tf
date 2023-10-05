variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Allowed values for environment_quality are \"DEV\", \"TEST\", or \"PROD\"."
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

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
  default     = null
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], coalesce(var.account_replication_type, "LRS"))
    error_message = "Allowed values for account_replication_type are 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS' and 'RAGZRS'."
  }
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Allowed values for account_tier are 'Standard' and 'Premium'."
  }
}

variable "account_kind" {
  description = "The kind of account to create"
  type        = string
  default     = "StorageV2"
  validation {
    condition     = contains(["StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.account_kind)
    error_message = "Allowed values for account_kind are 'StorageV2', 'BlobStorage', 'FileStorage' or 'BlockBlobStorage'."
  }
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts"
  type        = string
  default     = null
  validation {
    condition     = contains(["Hot", "Cool"], coalesce(var.access_tier, "Hot"))
    error_message = "Allowed values for access_tier are 'Hot' and 'Cool'."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Allow or disallow access to the storage account with a shared key (including shared access signature (SAS))"
  type        = bool
  default     = true
}

variable "name" {
  description = "The override name for the resource"
  default     = null
}

variable "network_rules" {
  description = "An object to specify an array of subnet that have service level access."
  type = object({
    default_action             = string
    virtual_network_subnet_ids = list(string)   
  })
  default = null
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "enable_delete_lifecycle_rule" {
  description = "Enable the creation of a delete lifecycle rule"
  type        = bool
  default     = false
}

variable "management_policy_delete_retention_days" {
  description = "Number of days to retain before deleting blob files (This resource creation is behind (enable_delete_lifecycle_rule = true))"
  type        = number
  default     = 1
}

variable "enable_threat_protection" {
  description = "Enable threat protection on storage account resource"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "azure_monitor_diagnostic_setting" {
  type = object({
    enable                     = bool
    log_analytics_workspace_id = string

    # the number of days for which this Retention Policy should apply.
    # Setting this to 0 will retain the events indefinitely.
    retention_policy_days = number
  })
  default = {
    enable                     = false
    log_analytics_workspace_id = null
    retention_policy_days      = null
  }
  validation {
    condition     = (var.azure_monitor_diagnostic_setting.enable ? var.azure_monitor_diagnostic_setting.log_analytics_workspace_id != null : true)
    error_message = "To enable Azure monitor diagnostics, 'log_analytics_workspace_id' must be specified."
  }
  validation {
    condition     = (var.azure_monitor_diagnostic_setting.enable ? var.azure_monitor_diagnostic_setting.retention_policy_days != null : true)
    error_message = "To enable Azure monitor diagnostics, 'retention_policy_days' must be specified."
  }
  validation {
    condition     = (var.azure_monitor_diagnostic_setting.enable ? var.azure_monitor_diagnostic_setting.retention_policy_days >= 0 : true)
    error_message = "To enable Azure monitor diagnostics, 'retention_policy_days' must be equal or greater than zero."
  }
}

variable "enable_static_website" {
  description = "Enable static website"
  type        = bool
  default     = false
}

variable "static_website_index_page" {
  description = "Static website index page"
  type        = string
  default     = null
}

variable "storage_blob_cors_rule" {
  description = "Details of the required Service Fabric client certificates."
  type = map(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = null
}

variable "private_link_access" {
  description = "Network rule private link access"
  type = map(object({
    endpoint_resource_id = string
    endpoint_tenant_id   = string
  }))
  default = null
}

variable "disable_sa_diagnostic_retention_in_days" {
  description = "Flag to disable usage of storage account retention in days - required for new diagnostic settings due to MS phased deprecation of legacy retention model."
  type        = bool
  default     = false
}
