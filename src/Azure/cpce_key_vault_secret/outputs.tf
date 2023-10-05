output "id" {
  value       = azurerm_key_vault_secret.cpce_key_vault_secret.id
  description = "The Key Vault Secret ID."
}

output "version" {
  value       = azurerm_key_vault_secret.cpce_key_vault_secret.version
  description = "The current version of the Key Vault Secret."
}

output "versionless_id" {
  value       = azurerm_key_vault_secret.cpce_key_vault_secret.versionless_id
  description = "The Base ID of the Key Vault Secret."
}

output "name" {
  value       = azurerm_key_vault_secret.cpce_key_vault_secret.name
  description = "The name of the Key Vault Secret."
} 