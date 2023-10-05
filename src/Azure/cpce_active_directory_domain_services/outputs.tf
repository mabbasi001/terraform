output "id" {
  description = "The ID of the Azure AD Domain Service."
  value = azurerm_active_directory_domain_service.aadds.id
}

output "resource_id" {
  description = "The resource ID of the Azure AD Domain Service."
  value = azurerm_active_directory_domain_service.aadds.resource_id
}

output "name" {
  value = local.name
}

output "primary_replica_set" {
  description = "Details of the replica set containing the primary domain controllers."
  value = azurerm_active_directory_domain_service.aadds.initial_replica_set[0]
}
