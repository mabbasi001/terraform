resource "azurerm_key_vault_secret" "cpce_key_vault_secret" {
  key_vault_id = var.key_vault_id
  name         = var.name
  value        = var.value
  content_type = var.content_type
  tags         = merge({ managed_by_terraform = true }, var.tags)
}
