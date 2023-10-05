resource "azurerm_storage_table" "cpce_storage_table" {
  name                 = var.name
  storage_account_name = var.storage_account_name
}