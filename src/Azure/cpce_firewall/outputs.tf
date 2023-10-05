output "id" {
  description = "Firewall Id"
  value       = azurerm_firewall.cpce_firewall.id
}

output "ip" {
  description = "Firewall private ip address"
  value       = azurerm_firewall.cpce_firewall.ip_configuration[0].private_ip_address
}

