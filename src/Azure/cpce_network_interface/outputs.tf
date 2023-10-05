output "id" {
  value       = azurerm_network_interface.cpce_network_interface.id
  description = "The id of the network interface."
}

output "private_ip_address" {
  value       = azurerm_network_interface.cpce_network_interface.private_ip_address
  description = "The first private IP address of the network interface."
}