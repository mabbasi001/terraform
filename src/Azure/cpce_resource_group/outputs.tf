output "id" {
  value       = azurerm_resource_group.cpce_resource_group.id
  description = "The ID resource group"
}

output "name" {
  value       = azurerm_resource_group.cpce_resource_group.name
  description = "The name resource group"
}

output "location" {
  value       = azurerm_resource_group.cpce_resource_group.location
  description = "The Azure Region where the Resource Group exists"
}
