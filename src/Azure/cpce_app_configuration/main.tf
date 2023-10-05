locals {
  name = coalesce(var.name, lower(format("appconfig%s%s%s",
    var.customer_code != null ? "-${var.customer_code}": "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

resource "azurerm_app_configuration" "app_configuration" {
  name                = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_name

  identity {
    type = var.identity_type
    identity_ids = var.identity_ids
  }

# Supported when we move azurerm on from 2.95
#   encryption {
#     key_vault_key_identifier    = var.encryption.key_vault_key_identifier
#     identity_client_id          = var.encryption.identity_client_id
#   }
}
