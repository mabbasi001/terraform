locals {
  name = var.name != null ? var.name : lower(format("log%s",
    var.name_suffix != null ? var.name_suffix : ""
  ))
}

resource "azurerm_storage_management_policy" "sa_diagnostic_retention_policy" {
  storage_account_id = var.storage_account_id

  rule {
    name    = local.name
    enabled = true
    filters {
      prefix_match = var.container_filter_prefix
      blob_types   = var.blob_types
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than       = var.delete_blobs_after_last
        delete_after_days_since_last_access_time_greater_than   = var.delete_blobs_after_last_access_time_in_days
        delete_after_days_since_creation_greater_than           = var.delete_blobs_after_creation_time_in_days
      }

      snapshot {
        delete_after_days_since_creation_greater_than           = var.delete_snapshot_after_creation_time_in_days
      }
      
      version {
        delete_after_days_since_creation                        = var.delete_version_after_creation_time_in_days
      }
    }
  }
}
