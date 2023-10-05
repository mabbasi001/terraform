locals {
  name = coalesce(var.name, lower(format("vdpool%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : ""
  )))
}

resource "time_static" "time" {}

resource "azurerm_virtual_desktop_host_pool" "avdhostpool" {
  location                 = var.location
  resource_group_name      = var.resource_group_name
  name                     = local.name
  friendly_name            = local.name
  validate_environment     = var.validate_environment
  start_vm_on_connect      = var.start_vm_on_connect
  description              = var.description
  type                     = var.type
  maximum_sessions_allowed = var.maximum_sessions_allowed
  load_balancer_type       = var.load_balancer_type
  custom_rdp_properties    = var.custom_rdp_properties
  tags                     = merge({ managed_by_terraform = true }, var.tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
