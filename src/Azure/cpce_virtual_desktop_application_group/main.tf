locals {
  name = var.name != null ? var.name : lower(format("vdag%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
  var.group_type != null ? "-${var.group_type}" : ""))
  resource_group_name = var.resource_group_name
  location            = var.location
  type                = var.type
  host_pool_id        = var.host_pool_id
  description         = var.description
}

resource "azurerm_virtual_desktop_application_group" "avdappgroup" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location
  type                = local.type
  host_pool_id        = local.host_pool_id
  description         = local.description
  tags                = merge({ managed_by_terraform = true }, var.tags)
}
