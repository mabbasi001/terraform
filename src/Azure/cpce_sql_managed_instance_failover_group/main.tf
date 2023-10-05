locals {
  sql_fg_name = var.name != null ? var.name : lower(format("sqlfg%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_sql_managed_instance_failover_group" "cpce_sql_mi_failover_group" {
  name                        = local.sql_fg_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  managed_instance_name       = var.managed_instance_name
  partner_managed_instance_id = var.partner_managed_instance_id

  read_write_endpoint_failover_policy {
    mode          = var.endpoint_failover_policy_mode
    grace_minutes = var.endpoint_failover_policy_auto_grace_minutes
  }
}