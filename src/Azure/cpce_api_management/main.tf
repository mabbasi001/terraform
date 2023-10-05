locals {
  apim_name = var.name != null ? var.name : lower(format("apim%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_api_management" "cpce_apim" {
  name                = local.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = var.sku_name
  zones           = var.zones

  dynamic "additional_location" {
    for_each = var.additional_location
    content {
      location             = lookup(additional_location.value, "location", null)
      capacity             = lookup(additional_location.value, "capacity", null)
      zones                = lookup(additional_location.value, "zones", null)
      public_ip_address_id = lookup(additional_location.value, "public_ip_address_id", null)
      virtual_network_configuration {
        subnet_id = lookup(additional_location.value, "subnet_id", null)
      }
    }
  }

  client_certificate_enabled = var.client_certificate_enabled
  gateway_disabled           = var.gateway_disabled
  min_api_version            = var.min_api_version

  identity {
    type         = var.identity_type
    identity_ids = replace(var.identity_type, "UserAssigned", "") == var.identity_type ? null : var.identity_ids
  }

  protocols {
    enable_http2 = var.enable_http2
  }

  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = toset(var.virtual_network_configuration)
    content {
      subnet_id = virtual_network_configuration.value
    }
  }

  public_ip_address_id = var.public_ip_address_id
}