output "name" {
  description = "The name of the failover group."
  value       = local.sql_fg_name
}

output "id" {
  description = "The ID of the failover group."
  value       = azurerm_sql_managed_instance_failover_group.cpce_sql_mi_failover_group.id
}

output "partner_region" {
  description = "Location and Role of the partner region where partner region exists."
  value       = azurerm_sql_managed_instance_failover_group.cpce_sql_mi_failover_group.partner_region
}
