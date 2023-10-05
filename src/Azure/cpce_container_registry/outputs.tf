output "id" {
  value = azurerm_container_registry.cpce_container_registry.id
}

output "hostname" {
  value = azurerm_container_registry.cpce_container_registry.login_server
}

output "service_principal_id" {
  value = azuread_service_principal.cpce_service_principal.application_id
}

output "service_principal_password" {
  value     = azuread_service_principal_password.cpce_service_principal_password.value
  sensitive = true
}

