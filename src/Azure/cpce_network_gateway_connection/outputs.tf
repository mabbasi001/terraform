output "ids" {
  description = "Network Gateway Connection Ids"
  value       = azurerm_virtual_network_gateway_connection.cpce_network_gateway_connection.*.id
}

output "names" {
  description = "Network Gateway Connections"
  value       = azurerm_virtual_network_gateway_connection.cpce_network_gateway_connection.*.name
}