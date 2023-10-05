locals {
  name = var.name != null ? var.name : lower(format("egt%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_eventgrid_system_topic" "eventgrid_system_topic" {
  name                   = local.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  source_arm_resource_id = var.storage_account_id
  topic_type             = var.topic_type
  tags                   = merge({ managed_by_terraform = true }, var.tags)
}
