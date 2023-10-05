output "id" {
  description = "The resource ID of the virtual machine."
  value       = azurerm_windows_virtual_machine.vm.id
}

output "name" {
  description = "The name of the virtual machine."
  value       = azurerm_windows_virtual_machine.vm.name
}

output "computer_name" {
  description = "The host name of the virtual machine."
  value       = azurerm_windows_virtual_machine.vm.computer_name
}

output "private_ip_address" {
  description = "The Private IP address assigned to the virual machine's NIC."
  value       = azurerm_windows_virtual_machine.vm.private_ip_address
}

output "principal_id" {
  description = "The identity information appropriate to this resource."
  value       = azurerm_windows_virtual_machine.vm.identity[0].principal_id
  sensitive   = true
}
