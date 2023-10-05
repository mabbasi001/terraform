resource "azurerm_management_group_policy_assignment" "cpce_azure_management_group_policy_assignment" {
  name                 = var.name
  location             = var.location
  policy_definition_id = var.policy_definition_id
  management_group_id  = var.management_group_id
  description          = var.description
  display_name         = var.display_name

  identity {
    type = var.identity_type
  }

}
