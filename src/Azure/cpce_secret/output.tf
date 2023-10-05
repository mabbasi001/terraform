
output "secret_encrypted_encipherment_certificate" {
  value       = length(resource.azurerm_key_vault_secret.secret_encrypted) > 0 ? resource.azurerm_key_vault_secret.secret_encrypted[0].value : ""
  sensitive   = true
  description = "The encipherment certificate encrypted secret "
}

output "secret_encrypted_environment_manager" {
  value       = length(resource.azurerm_key_vault_secret.secret_encrypted_environment_manager) > 0 ? resource.azurerm_key_vault_secret.secret_encrypted_environment_manager[0].value : ""
  sensitive   = true
  description = "The environment manager encrypted secret. "
}

output "secret_encrypted_encipherment_certificate_name" {
  value       = length(resource.azurerm_key_vault_secret.secret_encrypted) > 0 ? resource.azurerm_key_vault_secret.secret_encrypted[0].name : ""
  sensitive   = true
  description = "The name of the encipherment certificate encrypted secret "
}

output "secret_encrypted_environment_manager_name" {
  value       = length(resource.azurerm_key_vault_secret.secret_encrypted_environment_manager) > 0 ? resource.azurerm_key_vault_secret.secret_encrypted_environment_manager[0].name : ""
  sensitive   = true
  description = "The name of the environment manager encrypted secret. "
}
