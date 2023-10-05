locals {
  name = var.name != null ? var.name : lower(format("sql%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
  version = "12.0"
}

resource "azurerm_sql_server" "cpce_sql_server" {
  resource_group_name          = var.resource_group_name
  location                     = var.location
  name                         = local.name
  version                      = local.version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  tags                         = merge({ managed_by_terraform = true }, var.tags)
}
