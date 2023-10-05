locals {
  name = var.name != null ? var.name : lower(format("sqldb%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_mssql_database" "cpce_sql_server_database" {
  name            = local.name
  server_id       = var.server_id
  collation       = var.collation
  license_type    = var.license_type
  max_size_gb     = var.max_size_gb
  read_scale      = var.read_scale
  sku_name        = var.sku_name
  zone_redundant  = var.zone_redundant
  elastic_pool_id = var.elastic_pool_id

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy != null ? toset(["1"]) : []
    content {
      state                      = threat_detection_policy.value["state"]
      disabled_alerts            = threat_detection_policy.value["disabled_alerts"]
      email_account_admins       = threat_detection_policy.value["email_account_admins"]
      email_addresses            = threat_detection_policy.value["email_addresses"]
      retention_days             = threat_detection_policy.value["retention_days"]
      storage_account_access_key = threat_detection_policy.value["storage_account_access_key"]
      storage_endpoint           = threat_detection_policy.value["storage_endpoint"]
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? toset(["1"]) : []
    content {
      weekly_retention  = long_term_retention_policy.value["weekly_retention"]
      monthly_retention = long_term_retention_policy.value["monthly_retention"]
      yearly_retention  = long_term_retention_policy.value["yearly_retention"]
      week_of_year      = long_term_retention_policy.value["week_of_year"]
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy != null ? toset(["1"]) : []
    content {
      retention_days = short_term_retention_policy.value["retention_days"]
    }
  }

  tags = merge({ managed_by_terraform = true }, var.tags)
}
