/**
 * # Terraform B2C Module Documentation
 *
 * This documentation provides details about the Terraform module for creating an Azure Active Directory B2C.
 * Azure Active Directory B2C provides business-to-customer identity as a service.
 *
 * ## Usage
 *
 * ## Requirements
 *
 * Make sure you have the following prerequisites:
 *
 * - Terraform CLI installed
 * - Azure CLI installed
 * - Azure subscription and credentials configured (user account to interact with UI)
 * - Directory Creation role or higher
 * -
 */
locals {
  cert_name               = var.b2c_display_name
  display_name            = var.b2c_display_name
  domain_name             = var.b2c_domain_name
  data_residency_location = var.b2c_data_residency_location
  sku_name                = var.b2c_sku
  country_code            = var.b2c_region
  environment_rg_name     = var.environment_rg_name
  az_account_name         = var.az_account_name
}
# A separated Resource Group for Azure AD B2C resources as can be destroyed with same process of creating general resource group
resource "azurerm_resource_group" "b2c_rg" {
  name     = "${local.environment_rg_name}-b2c"
  location = var.location
}

resource "azurerm_aadb2c_directory" "aadb2c" {
  display_name = local.display_name
  domain_name = "${local.display_name}.${local.domain_name}"
  resource_group_name = azurerm_resource_group.b2c_rg.name
  data_residency_location = local.data_residency_location
  sku_name = local.sku_name
  country_code = local.country_code
}