output "id" {
  value       = azurerm_availability_set.cpce_availability_set.id
  description = "The id of the Availability Set."
}

output "name" {
  value       = azurerm_availability_set.cpce_availability_set.name
  description = "The name of the Availability Set."
}

output "fault_domain_count" {
  value       = azurerm_availability_set.cpce_availability_set.platform_fault_domain_count
  description = "The fault_domain_count of the Availability Set."
}

output "update_domain_count" {
  value       = azurerm_availability_set.cpce_availability_set.platform_update_domain_count
  description = "The update_domain_count of the Availability Set."
} 