locals {
  name = var.name != null ? var.name : lower(format("avail%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))

}

resource "azurerm_availability_set" "cpce_availability_set" {
  resource_group_name          = var.resource_group_name
  name                         = local.name
  location                     = var.location
  platform_fault_domain_count  = var.fault_domain_count
  platform_update_domain_count = var.update_domain_count
  managed                      = true
  tags                         = merge({ managed_by_terraform = true }, var.tags)
}
