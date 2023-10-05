resource "azurerm_automation_module" "cpce_automation_account_module" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name

  module_link {
    uri = var.content_link
  }
}
