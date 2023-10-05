output "id" {
  value = var.ignore_email_changes ? azurerm_monitor_action_group.cpce_monitor_action_group_ignore_email[0].id : azurerm_monitor_action_group.cpce_monitor_action_group[0].id
}