output "id" {
  value       = azurerm_private_endpoint.cpce_private_endpoint.id
  description = "The ID of the resource"
  sensitive   = true
}

output "name" {
  value       = azurerm_private_endpoint.cpce_private_endpoint.name
  description = "The name of the resource"
}

output "location" {
  value       = azurerm_private_endpoint.cpce_private_endpoint.location
  description = "The location of the resource"
}

output "tags" {
  value       = azurerm_private_endpoint.cpce_private_endpoint.tags
  description = "Tags which are on this resource"
}

output "network_interface_id" {
  description = "The ID of the network interface associated to the resource."
  value       = azurerm_private_endpoint.cpce_private_endpoint.network_interface.*.id
  sensitive   = true
}

output "private_dns_zone_group_id" {
  description = "The ID of the private dns zone associated to the resource."
  value       = azurerm_private_endpoint.cpce_private_endpoint.private_dns_zone_group.*.id
  sensitive   = true
}

output "private_ip_address" {
  description = "The private IP address of the private endpoint."
  value       = azurerm_private_endpoint.cpce_private_endpoint.private_service_connection.*.private_ip_address
}

