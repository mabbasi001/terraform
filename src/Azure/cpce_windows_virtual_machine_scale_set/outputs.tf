output "id" {
  description = "The Resource ID of the Windows Virtual Machine Scale Set."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.id
}

output "unique_id" {
  description = "The Unique ID for this Windows Virtual Machine Scale Set."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.unique_id
}

output "name" {
  description = "The name of the virtual machine scale set."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.name
}

output "managed_identity" {
  description = "Details of the managed identity under which the virtual machine scale set is configured to run."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.identity
}