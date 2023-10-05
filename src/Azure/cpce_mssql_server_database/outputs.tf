output "id" {
  value       = azurerm_mssql_database.cpce_sql_server_database.id
  description = "The ID of the Azure SQL Database"
  sensitive   = true
}

output "name" {
  value       = azurerm_mssql_database.cpce_sql_server_database.name
  description = "The name of the Azure SQL Server"
}

output "tags" {
  value       = azurerm_mssql_database.cpce_sql_server_database.tags
  description = "Tags which are on this resource"
}

