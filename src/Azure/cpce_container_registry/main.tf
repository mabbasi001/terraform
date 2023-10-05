resource "azurecaf_name" "name" {
  name           = var.name
  resource_types = ["azurerm_container_registry"]
  suffixes       = [var.location, var.environment_code]
  random_length  = 4
  clean_input    = true
  passthrough    = var.skip_caf_name_generation
}

resource "azurerm_container_registry" "cpce_container_registry" {
  name                = azurecaf_name.name.results.azurerm_container_registry
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false # For security reasons even if default is false
}

resource "azuread_application" "cpce_azuread_application" {
  display_name = "ACR ${azurerm_container_registry.cpce_container_registry.name} Service Principal"
}

resource "azuread_service_principal" "cpce_service_principal" {
  application_id = azuread_application.cpce_azuread_application.application_id
}

resource "azuread_service_principal_password" "cpce_service_principal_password" {
  service_principal_id = azuread_service_principal.cpce_service_principal.id
}

resource "azurerm_key_vault_secret" "cpce_key_vault_secret_id" {
  name         = "acr-${azurerm_container_registry.cpce_container_registry.name}-username"
  value        = azuread_service_principal.cpce_service_principal.application_id
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "cpce_key_vault_secret_password" {
  name         = "acr-${azurerm_container_registry.cpce_container_registry.name}-password"
  value        = azuread_service_principal_password.cpce_service_principal_password.value
  key_vault_id = var.key_vault_id
}

resource "azurerm_role_assignment" "azurerm_role_assignment" {
  scope                = azurerm_container_registry.cpce_container_registry.id
  role_definition_name = "AcrPush"
  principal_id         = azuread_service_principal.cpce_service_principal.id
}
