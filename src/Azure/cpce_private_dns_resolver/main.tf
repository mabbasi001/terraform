locals {
  name = coalesce(var.name, lower(format("dnspr%s%s%s",
    var.customer_code != null ? "-${var.customer_code}": "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

resource "azurerm_private_dns_resolver" "hub_resolver" {
  name                = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "hub_resolver_outbound_endpoint" {
  for_each                = var.outbound_endpoints

  name                    = each.value.name
  private_dns_resolver_id = azurerm_private_dns_resolver.hub_resolver.id
  location                = azurerm_private_dns_resolver.hub_resolver.location
  subnet_id               = each.value.subnet_id
}
