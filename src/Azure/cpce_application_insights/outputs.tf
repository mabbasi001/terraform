output "id" {
  value = azurerm_application_insights.cpce_application_insights.id
}
output "name" {
  value = azurerm_application_insights.cpce_application_insights.name
}
output "instrumentation_key" {
  value     = azurerm_application_insights.cpce_application_insights.instrumentation_key
  sensitive = true
}
output "connection_string" {
  value     = azurerm_application_insights.cpce_application_insights.connection_string
  sensitive = true
}