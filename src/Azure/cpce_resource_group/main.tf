locals {
  name = var.name != null ? var.name : lower(format("rg%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_resource_group" "cpce_resource_group" {
  name     = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  location = var.location
  tags     = merge({ managed_by_terraform = true }, var.tags)
}
