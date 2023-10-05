locals {
  workspace_id         = var.workspace_id
  application_group_id = var.application_group_id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "avd_workspace_appgroup_association" {
  workspace_id         = local.workspace_id
  application_group_id = local.application_group_id
}