locals {
  name = var.name != null ? var.name : lower(format("sa%s%s%s",
    var.customer_code != null ? var.customer_code : "",
    var.environment_code != null ? var.environment_code : "",
    var.name_suffix != null ? var.name_suffix : ""
  ))
}

locals {
  #lookuptables
  account_replication_type_default = lookup(
    {
      PROD = "GRS"
      DEV  = "LRS"
      TEST = "LRS"
    },
    var.environment_quality, "LRS"
  )
  access_tier_default = lookup(
    {
      StorageV2   = "Hot"
      FileStorage = "Hot"
      BlobStorage = "Hot"
    },
    var.account_kind, ""
  )
  management_policy_delete_retention_days_default = lookup(
    {
      PROD = 2
      TEST = 2
      DEV  = 1
    },
    var.management_policy_delete_retention_days, 1
  )
}

resource "azurerm_storage_account" "cpce_storage_account" {
  resource_group_name             = var.resource_group_name
  location                        = var.location
  name                            = substr(local.name, 0, 24)
  account_replication_type        = var.account_replication_type != null ? var.account_replication_type : local.account_replication_type_default
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  access_tier                     = var.access_tier != null ? var.access_tier : local.access_tier_default
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  enable_https_traffic_only       = true
  shared_access_key_enabled       = var.shared_access_key_enabled
  #default_to_oauth_authentication = var.default_to_oauth_authentication  # To be added in a later version of Terraform Provider
  min_tls_version = "TLS1_2"
  is_hns_enabled  = var.is_hns_enabled
  tags            = merge({ managed_by_terraform = true }, var.tags)

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [1] : []
    content {
      default_action             = var.network_rules["default_action"]
      virtual_network_subnet_ids = var.network_rules["virtual_network_subnet_ids"]
      dynamic "private_link_access" {
        for_each = var.private_link_access != null ? var.private_link_access : {}
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.enable_static_website ? [1] : []
    content {
      index_document = var.static_website_index_page
    }
  }

  dynamic "blob_properties" {
    for_each = var.account_kind != "FileStorage" && var.storage_blob_cors_rule != null ? ["1"] : []
    
    content {
      dynamic "cors_rule" {
        for_each = var.storage_blob_cors_rule != null ? var.storage_blob_cors_rule : {}
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      azure_files_authentication
    ]
  }
}

data "azurerm_monitor_diagnostic_categories" "storage_diagnostic_categories" {
  resource_id = azurerm_storage_account.cpce_storage_account.id
}

data "azurerm_monitor_diagnostic_categories" "storage_file_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.cpce_storage_account.id}/fileServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "storage_blob_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.cpce_storage_account.id}/blobServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "storage_queue_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.cpce_storage_account.id}/queueServices/default/"
}

data "azurerm_monitor_diagnostic_categories" "storage_table_diagnostic_categories" {
  resource_id = "${azurerm_storage_account.cpce_storage_account.id}/tableServices/default/"
}

# Add storage account monitoring settings
resource "azurerm_monitor_diagnostic_setting" "cpce_storage_account_diagnostic_setting" {
  count                      = var.azure_monitor_diagnostic_setting.enable ? 1 : 0
  name                       = "${azurerm_storage_account.cpce_storage_account.name}-azurerm-monitor-diagnostic-setting"
  target_resource_id         = azurerm_storage_account.cpce_storage_account.id
  log_analytics_workspace_id = var.azure_monitor_diagnostic_setting.log_analytics_workspace_id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_diagnostic_categories.logs
    content {
      category = entry.value
      enabled  = true
      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_diagnostic_categories.metrics

    content {
      category = entry.value
      enabled  = true
      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
}

# Add file monitoring settings
resource "azurerm_monitor_diagnostic_setting" "cpce_storage_account_file_diagnostic_setting" {
  count                      = var.azure_monitor_diagnostic_setting.enable ? 1 : 0
  name                       = "${azurerm_storage_account.cpce_storage_account.name}-file-azurerm-monitor-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.cpce_storage_account.id}/fileServices/default/"
  log_analytics_workspace_id = var.azure_monitor_diagnostic_setting.log_analytics_workspace_id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_file_diagnostic_categories.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_file_diagnostic_categories.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
}

# Add blob monitoring settings
resource "azurerm_monitor_diagnostic_setting" "cpce_storage_account_blob_diagnostic_setting" {
  count                      = var.azure_monitor_diagnostic_setting.enable ? 1 : 0
  name                       = "${azurerm_storage_account.cpce_storage_account.name}-blob-azurerm-monitor-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.cpce_storage_account.id}/blobServices/default/"
  log_analytics_workspace_id = var.azure_monitor_diagnostic_setting.log_analytics_workspace_id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob_diagnostic_categories.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob_diagnostic_categories.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
}

# Add queue monitoring settings
resource "azurerm_monitor_diagnostic_setting" "cpce_storage_account_queue_diagnostic_setting" {
  count                      = var.azure_monitor_diagnostic_setting.enable ? 1 : 0
  name                       = "${azurerm_storage_account.cpce_storage_account.name}-queue-azurerm-monitor-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.cpce_storage_account.id}/queueServices/default/"
  log_analytics_workspace_id = var.azure_monitor_diagnostic_setting.log_analytics_workspace_id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_queue_diagnostic_categories.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_queue_diagnostic_categories.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
}

# Add table monitoring settings
resource "azurerm_monitor_diagnostic_setting" "cpce_storage_account_table_diagnostic_setting" {
  count                      = var.azure_monitor_diagnostic_setting.enable ? 1 : 0
  name                       = "${azurerm_storage_account.cpce_storage_account.name}-table-azurerm-monitor-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.cpce_storage_account.id}/tableServices/default/"
  log_analytics_workspace_id = var.azure_monitor_diagnostic_setting.log_analytics_workspace_id

  dynamic "log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_table_diagnostic_categories.logs

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_table_diagnostic_categories.metrics

    content {
      category = entry.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.disable_sa_diagnostic_retention_in_days ? 0 : var.azure_monitor_diagnostic_setting.retention_policy_days
      }
    }
  }
}

# Data Lake Deletion Lifecycle Rule
resource "azurerm_storage_management_policy" "cpce_storage_account_management_policy" {
  storage_account_id = azurerm_storage_account.cpce_storage_account.id
  for_each           = var.enable_delete_lifecycle_rule ? toset(["1"]) : []

  rule {
    name    = "DataLakeFileRetention"
    enabled = true
    filters {
      blob_types = [
        "blockBlob",
        "appendBlob"
      ]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than = var.management_policy_delete_retention_days != null ? var.management_policy_delete_retention_days : local.management_policy_delete_retention_days_default
        #delete_after_days_since_creation_greater_than = var.management_policy_delete_retention_days != null ? var.management_policy_delete_retention_days : local.management_policy_delete_retention_days_default # To be used in a later version of azurerm
      }
    }
  }
}

resource "azurerm_advanced_threat_protection" "cpce_storage_account_threat_protection" {
  target_resource_id = azurerm_storage_account.cpce_storage_account.id
  enabled            = var.enable_threat_protection
}
