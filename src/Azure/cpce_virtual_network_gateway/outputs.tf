output "id" {
  description = "Resource ID of the Virtual Network Gateway resource."
  value       = azurerm_virtual_network_gateway.vnet_gateway.id
}

output "name" {
  description = "Name of the Virtual Network Gateway resource."
  value       = local.name
}