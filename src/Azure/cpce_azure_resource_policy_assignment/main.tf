resource "azurerm_resource_policy_assignment" "cpce_azure_resource_policy_assignment" {
  name                 = var.name
  location             = var.location
  policy_definition_id = var.policy_definition_id
  resource_id          = var.resource_id
  description          = var.description
  display_name         = var.display_name

  identity {
    type = var.identity_type
  }

}
