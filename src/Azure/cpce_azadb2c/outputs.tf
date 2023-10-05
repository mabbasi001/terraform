#=====================================================
# Define the output variable for the Azure AD B2C.
#=====================================================
# These outputs provide information about Azure AD B2C.
output "id" {
  description = "The resource ID of the Azure AD B2C tenant."
  value = azurerm_aadb2c_directory.aadb2c.id
}

output "domain_name" {
  description = "The custom domain name associated with the Azure AD B2C tenant."
  value = azurerm_aadb2c_directory.aadb2c.domain_name
}

output "tenant_id" {
  description = "provide me a short description for azurerm_aadb2c_directory.aadb2c.tenant_id to use in terraform output"
  value       = azurerm_aadb2c_directory.aadb2c.tenant_id
}

output "azcli_account_name" {
  description = "The name of the Azure CLI account used for authentication."
  value       = local.az_account_name #data.external.az_account_name.result
}

output "resource_group_name" {
  description = "Resource group name created with the B2C resource."
  value       = azurerm_resource_group.b2c_rg.name
}