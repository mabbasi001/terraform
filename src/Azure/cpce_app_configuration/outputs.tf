output "id" {
  value       = azurerm_app_configuration.app_configuration.id
  description = "The ID of the resource"
  sensitive   = true
}

output "name" {
  value       = azurerm_app_configuration.app_configuration.name
  description = "The name of the resource"
  sensitive   = true
}

output "endpoint" {
  value       = azurerm_app_configuration.app_configuration.endpoint
  description = "The endpoint of the resource"
}

output "identity_principal_id" {
  value       = azurerm_app_configuration.app_configuration.identity[0].principal_id
  description = "The id of the service principal for the managed identity."
  sensitive   = true
}

output "identity_tenant_id" {
  value       = azurerm_app_configuration.app_configuration.identity[0].tenant_id
  description = "The id of the tenant for the managed identity."
  sensitive   = true
}
