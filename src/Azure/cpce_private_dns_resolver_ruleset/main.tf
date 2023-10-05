locals {
  name = coalesce(var.name, lower(format("rs%s%s%s",
    var.customer_code != null ? "-${var.customer_code}": "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "hub_resolver_rule_set" {
  name                                       = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = var.outbound_endpoint_ids
}

resource "azurerm_private_dns_resolver_virtual_network_link" "hub_resolver_vnet_link" {
  name                      = "link-${var.customer_code} -${var.environment_code}"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.hub_resolver_rule_set.id
  virtual_network_id        = var.virtual_network_id
}
