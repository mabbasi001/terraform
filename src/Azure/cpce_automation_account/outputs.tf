output "id" {
  value = azurerm_automation_account.cpce_automation_account.id
}
output "name" {
  value = azurerm_automation_account.cpce_automation_account.name
}
output "dsc_server_endpoint" {
  value = azurerm_automation_account.cpce_automation_account.dsc_server_endpoint
}
output "dsc_primary_access_key" {
  value     = azurerm_automation_account.cpce_automation_account.dsc_primary_access_key
  sensitive = true
}
output "dsc_secondary_access_key" {
  value     = azurerm_automation_account.cpce_automation_account.dsc_secondary_access_key
  sensitive = true
}


