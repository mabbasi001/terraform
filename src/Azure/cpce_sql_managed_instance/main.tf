locals {
  sql_mi_name = var.name != null ? var.name : lower(format("sqlmi%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

data "azurerm_client_config" "current" {
}

resource "azurerm_sql_managed_instance" "cpce_sqlmi" {
  name                = local.sql_mi_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  license_type                 = var.license_type
  subnet_id                    = var.subnet_id
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb
  collation                    = var.collation
  public_data_endpoint_enabled = false
  minimum_tls_version          = var.minimum_tls_version
  proxy_override               = var.proxy_override
  timezone_id                  = var.timezone_id
  dns_zone_partner_id          = var.dns_zone_partner_id

  identity {
    type = "SystemAssigned"
  }
}

