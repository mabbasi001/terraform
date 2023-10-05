locals {
  name = var.name != null ? var.name : lower(format("egt%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_eventgrid_topic" "eventgrid_topic" {
  name                          = local.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = var.enable_public_access
  tags                          = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_key_vault_secret" "eventgrid_topic_primary_access_key" {
  name         = lower("${azurerm_eventgrid_topic.eventgrid_topic.name}-primary-access-key")
  value        = azurerm_eventgrid_topic.eventgrid_topic.primary_access_key
  key_vault_id = var.key_vault_id
  content_type = "Event Grid Topic Access Key"
  tags         = { managed_by_terraform = true }
}

resource "azurerm_key_vault_secret" "eventgrid_topic_secondary_access_key" {
  name         = lower("${azurerm_eventgrid_topic.eventgrid_topic.name}-secondary-access-key")
  value        = azurerm_eventgrid_topic.eventgrid_topic.secondary_access_key
  key_vault_id = var.key_vault_id
  content_type = "Event Grid Topic Access Key"
  tags         = { managed_by_terraform = true }
}
