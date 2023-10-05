locals {
  name = var.name != null ? var.name : lower(format("nic%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_network_interface" "cpce_network_interface" {
  resource_group_name         = var.resource_group_name
  name                        = local.name
  location                    = var.location
  internal_domain_name_suffix = null
  tags                        = merge({ managed_by_terraform = true }, var.tags)

  ip_configuration {
    name                          = "ip-configuration-${local.name}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }

  lifecycle {
    ignore_changes = [
    ]
  }
}
