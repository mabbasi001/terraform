locals {
  resource_group_name = var.resource_group_name
  location            = var.location
  name = coalesce(var.name, lower(format("vdws%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : ""
  )))
  description = var.description
  friendly_name = upper(format("%s%s",
    var.customer_code != null ? "${var.customer_code}" : "",
    var.environment_code != null ? " ${var.environment_code}" : ""
  ))
}

resource "azurerm_virtual_desktop_workspace" "avd_workspace" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location
  description         = local.description
  friendly_name       = local.friendly_name
  tags                = merge(var.tags, { managed_by_terraform = true })
}