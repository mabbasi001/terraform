output "id" {
  value = azurerm_linux_web_app.cpce_linux_web_app.id
}

output "name" {
  value = azurecaf_name.name.result
}

output "default_hostname" {
  value = azurerm_linux_web_app.cpce_linux_web_app.default_hostname
}

output "identity" {
  value = azurerm_linux_web_app.cpce_linux_web_app.identity
}
