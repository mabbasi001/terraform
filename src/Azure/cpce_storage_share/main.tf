resource "azurerm_storage_share" "cpce_storage_share" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  quota                = var.storage_quota
}