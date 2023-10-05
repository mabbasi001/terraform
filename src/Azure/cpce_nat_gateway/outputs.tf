output "id" {
  description = "Nat Gateway Id"
  value       = azurerm_nat_gateway.cpce_nat_gateway.id
}

output "name" {
  description = "Nat gateway Name"
  value       = azurerm_nat_gateway.cpce_nat_gateway.name
}