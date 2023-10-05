output "id" {
  value = azurerm_storage_account.cpce_storage_account.id
}
output "name" {
  value = azurerm_storage_account.cpce_storage_account.name
}
output "location" {
  value = azurerm_storage_account.cpce_storage_account.location
}
output "account_tier" {
  value = azurerm_storage_account.cpce_storage_account.account_tier
}
output "account_kind" {
  value = azurerm_storage_account.cpce_storage_account.account_kind
}
output "access_tier" {
  value = azurerm_storage_account.cpce_storage_account.access_tier
}
output "primary_location" {
  value = azurerm_storage_account.cpce_storage_account.primary_location
}
output "secondary_location" {
  value = azurerm_storage_account.cpce_storage_account.secondary_location
}
output "primary_blob_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.primary_blob_endpoint
}
output "secondary_blob_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.secondary_blob_endpoint
}
output "primary_queue_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.primary_queue_endpoint
}
output "secondary_queue_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.secondary_queue_endpoint
}
output "primary_table_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.primary_table_endpoint
}
output "secondary_table_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.secondary_table_endpoint
}
output "primary_file_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.primary_file_endpoint
}
output "secondary_file_endpoint" {
  value = azurerm_storage_account.cpce_storage_account.secondary_file_endpoint
}

output "primary_access_key" {
  value     = azurerm_storage_account.cpce_storage_account.primary_access_key
  sensitive = true
}
output "secondary_access_key" {
  value     = azurerm_storage_account.cpce_storage_account.secondary_access_key
  sensitive = true
}
output "primary_connection_string" {
  value     = azurerm_storage_account.cpce_storage_account.primary_connection_string
  sensitive = true
}
output "secondary_connection_string" {
  value     = azurerm_storage_account.cpce_storage_account.secondary_connection_string
  sensitive = true
}
output "primary_web_endpoint" {
  value     = azurerm_storage_account.cpce_storage_account.primary_web_endpoint
}


