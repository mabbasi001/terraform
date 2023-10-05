output "id" {
  value       = azurerm_sql_server.cpce_sql_server.id
  description = "The ID of the Azure SQL Server"
}

output "name" {
  value       = azurerm_sql_server.cpce_sql_server.name
  description = "The name of the Azure SQL Server"
}

output "location" {
  value       = azurerm_sql_server.cpce_sql_server.location
  description = "The location of the Azure SQL Server"
}

output "tags" {
  value       = azurerm_sql_server.cpce_sql_server.tags
  description = "Tags which are on this resource"
}
