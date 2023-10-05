locals {
  name = var.name != null ? var.name : lower(format("pep%s%s%s%s",
    var.resource_identifier != null ? "-${var.resource_identifier}" : "",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_private_endpoint" "cpce_private_endpoint" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = var.private_dns_zone_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = local.name
    is_manual_connection           = var.private_connection_approval_is_manual
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.private_connection_subresource_names
  }
}
