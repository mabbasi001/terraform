locals {
  name = var.name != null ? var.name : lower(format("ngw%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_nat_gateway" "cpce_nat_gateway" {
  name                    = local.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.sku_name
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_nat_gateway_public_ip_association" "cpce_nat_gateway" {
  count                = var.public_ip_addresses == null ? 0 : length(var.public_ip_addresses)
  nat_gateway_id       = azurerm_nat_gateway.cpce_nat_gateway.id
  public_ip_address_id = var.public_ip_addresses[count.index]
}

resource "azurerm_subnet_nat_gateway_association" "cpce_nat_gateway" {
  count          = var.subnet_ids == null ? 0 : length(var.subnet_ids)
  nat_gateway_id = azurerm_nat_gateway.cpce_nat_gateway.id
  subnet_id      = var.subnet_ids[count.index]
}
