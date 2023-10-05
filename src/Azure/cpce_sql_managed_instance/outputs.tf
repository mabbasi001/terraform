output "name" {
  description = "The name of the managed instance."
  value       = local.sql_mi_name
}

output "fqdn" {
  description = "The fully qualified domain name of the Azure Managed SQL Instance."
  value       = azurerm_sql_managed_instance.cpce_sqlmi.fqdn
}

output "id" {
  description = "The SQL Managed Instance ID."
  value       = azurerm_sql_managed_instance.cpce_sqlmi.id
}

output "identity_principal_id" {
  description = "The Principal ID for the Service Principal associated with the Identity of this SQL Managed Instance."
  value       = one(azurerm_sql_managed_instance.cpce_sqlmi.identity[*].principal_id)
  sensitive   = true
}

