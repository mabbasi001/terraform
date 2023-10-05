output "name" {
  description = "The name of the failover group."
  value       = local.sql_fg_name
}

output "id" {
  description = "The ID of the failover group."
  value       = azurerm_sql_failover_group.cpce_sql_server_failover_group.id
}
