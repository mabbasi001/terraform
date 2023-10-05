locals {
  name = var.name != null ? var.name : lower(format("aa%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_automation_account" "cpce_automation_account" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name
  tags                = merge({ managed_by_terraform = true }, var.tags)

  dynamic "identity" {
    for_each = var.managed_identity != null ? [1] : []
    content {
      type = var.managed_identity
    }
  }
}
