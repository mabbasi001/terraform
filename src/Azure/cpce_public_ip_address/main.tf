locals {
  name = var.name != null ? var.name : lower(format("pip%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_public_ip" "cpce_public_ip" {
  resource_group_name = var.resource_group_name
  name                = local.name
  location            = var.location
  sku                 = coalesce(var.sku, "Basic")
  allocation_method   = coalesce(var.allocation_method, "Static")
  tags                = merge({ managed_by_terraform = true }, var.tags)
  zones               = var.zones
}
