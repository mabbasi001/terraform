output "id" {
  value = azurerm_log_analytics_workspace.cpce_log_analytics_workspace.id
}

output "name" {
  value = azurerm_log_analytics_workspace.cpce_log_analytics_workspace.name
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.cpce_log_analytics_workspace.workspace_id
}

output "primary_shared_key" {
  value     = azurerm_log_analytics_workspace.cpce_log_analytics_workspace.primary_shared_key
  sensitive = true
}

output "secondary_shared_key" {
  value     = azurerm_log_analytics_workspace.cpce_log_analytics_workspace.secondary_shared_key
  sensitive = true
}