locals {
  name = var.name != null ? var.name : lower(format("vnet%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_virtual_network" "cpce_virtual_network" {
  name                = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = merge({ managed_by_terraform = true }, var.tags)
}