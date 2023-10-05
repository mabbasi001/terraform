output "id" {
  value       = azurerm_mssql_server.cpce_sql_server.id
  description = "The ID of the Azure SQL Server"
  sensitive   = true
}

output "name" {
  value       = azurerm_mssql_server.cpce_sql_server.name
  description = "The name of the Azure SQL Server"
}

output "location" {
  value       = azurerm_mssql_server.cpce_sql_server.location
  description = "The location of the Azure SQL Server"
}

output "tags" {
  value       = azurerm_mssql_server.cpce_sql_server.tags
  description = "Tags which are on this resource"
}

output "identity_principal_id" {
  description = "The Principal ID for the Service Principal associated with the Identity of this SQL Server."
  value       = azurerm_mssql_server.cpce_sql_server.identity.*.principal_id
  sensitive   = true
}