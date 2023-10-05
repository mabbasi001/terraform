locals {
  name = var.name != null ? var.name : lower(format("kv%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))

  default_soft_delete_retention_period_in_days = lookup(
    {
      PROD = 90
      TEST = 30
      DEV  = 7
    },
    var.quality, 90
  )

  default_purge_protection_enabled = lookup(
    {
      PROD = true
      TEST = false
      DEV  = false
    },
    var.quality, false
  )
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "cpce_key_vault" {
  name                            = local.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = coalesce(var.purge_protection_enabled, local.default_purge_protection_enabled)
  soft_delete_retention_days      = coalesce(var.soft_delete_retention_days, local.default_soft_delete_retention_period_in_days)
  tags                            = merge({ managed_by_terraform = true }, var.tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      contact
    ]
  }
}
