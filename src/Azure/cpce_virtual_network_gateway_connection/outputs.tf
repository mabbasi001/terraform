output "id" {
  description = "Resource ID of the Virtual Network Gateway Connection resource."
  value       = azurerm_virtual_network_gateway_connection.vpn_connection.id
}

output "name" {
  description = "Name of the Virtual Network Gateway Connection resource."
  value       = azurerm_virtual_network_gateway_connection.vpn_connection.name
}

output "local_network_gateway_id" {
  description = "Resource ID of the Local Network Gateway resource"
  value       = azurerm_local_network_gateway.onprem_network.*.id
}

output "shared_key" {
  description = "Shared key of the Virtual Network Gateway Connection."
  value       = var.remote_network_gateway_shared_key != null ? var.remote_network_gateway_shared_key : module.shared_key[0].result
  sensitive   = true
}