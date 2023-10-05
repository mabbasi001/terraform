output "id" {
  description = "The resource ID of the azure api management."
  value       = azurerm_api_management.cpce_apim.id
}

output "name" {
  description = "The resource name of the azure api management."
  value       = azurerm_api_management.cpce_apim.name
}

output "additional_location" {
  description = "additional hosted locations of the azure api management."
  value       = azurerm_api_management.cpce_apim.additional_location
}

output "public_ip_addresses" {
  description = "The public ip addresses of the azure api management."
  value       = azurerm_api_management.cpce_apim.public_ip_addresses
}

output "private_ip_addresses" {
  description = "The private ip addresses of the azure api management."
  value       = azurerm_api_management.cpce_apim.private_ip_addresses
}

output "gateway_url" {
  description = "The gateway url of the azure api management."
  value       = azurerm_api_management.cpce_apim.gateway_url
}

output "gateway_regional_url" {
  description = "The gateway url of the azure api management."
  value       = azurerm_api_management.cpce_apim.gateway_regional_url
}

output "management_api_url" {
  description = "The management api url of the azure api management."
  value       = azurerm_api_management.cpce_apim.management_api_url
}

output "portal_url" {
  description = "The portal url of the azure api management."
  value       = azurerm_api_management.cpce_apim.portal_url
}

output "developer_portal_url" {
  description = "The developer portal url of the azure api management."
  value       = azurerm_api_management.cpce_apim.developer_portal_url
}

output "scm_url" {
  description = "The SCM (Source Code Management) Endpoint associated with the azure api management."
  value       = azurerm_api_management.cpce_apim.scm_url
}

