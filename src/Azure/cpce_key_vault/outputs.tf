output "id" {
  value       = azurerm_key_vault.cpce_key_vault.id
  description = "The ID of the Key Vault"
}

output "name" {
  value       = azurerm_key_vault.cpce_key_vault.name
  description = "The name of the Key Vault"
}

output "location" {
  value       = azurerm_key_vault.cpce_key_vault.location
  description = "The location of the Key Vault"
}

output "sku_name" {
  value       = azurerm_key_vault.cpce_key_vault.sku_name
  description = "The sku of the Key Vault"
}

output "vault_uri" {
  value       = azurerm_key_vault.cpce_key_vault.vault_uri
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
}

output "enabled_for_deployment" {
  value       = azurerm_key_vault.cpce_key_vault.enabled_for_deployment
  description = "Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault"
}

output "enabled_for_disk_encryption" {
  value       = azurerm_key_vault.cpce_key_vault.enabled_for_disk_encryption
  description = "Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
}

output "enabled_for_template_deployment" {
  value       = azurerm_key_vault.cpce_key_vault.enabled_for_template_deployment
  description = "Azure Resource Manager is permitted to retrieve secrets from the key vault"
}

output "tags" {
  value       = azurerm_key_vault.cpce_key_vault.tags
  description = "Tags which are on this resource"
}
