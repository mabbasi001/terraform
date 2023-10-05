locals {
  should_create_metric_alert = var.reference_action_group || length(var.alert_emails) > 0
  should_create_action_group = local.should_create_metric_alert && var.reference_action_group == false
}

resource "azurerm_application_insights_web_test" "cpce_application_insights_web_test" {
  name                    = azurecaf_name.azurerm_application_insights_web_test.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 60
  enabled                 = true
  geo_locations           = var.web_test_geo_locations

  configuration           = var.web_test_configuration

  tags                    = merge({ managed_by_terraform = true, "hidden-link:${var.application_insights_id}" = "Resource" }, var.tags)
}

resource "azurerm_monitor_action_group" "cpce_monitor_action_group" {
  count = local.should_create_action_group ? 1 : 0

  name                = azurecaf_name.azurerm_monitor_action_group[0].result
  resource_group_name = var.resource_group_name
  short_name          = var.name

  dynamic "email_receiver" {
    iterator = email
    for_each = var.alert_emails

    content {
      name          = "email-${email.value}"
      email_address = email.value
    }
  }
}

resource "azurerm_monitor_metric_alert" "cpce_monitor_metric_alert" {
  count = local.should_create_metric_alert ? 1 : 0

  name                = azurecaf_name.azurerm_monitor_metric_alert[0].result
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_insights_web_test.cpce_application_insights_web_test.id, var.application_insights_id]
  description         = var.alert_description

  application_insights_web_test_location_availability_criteria {
    web_test_id           = azurerm_application_insights_web_test.cpce_application_insights_web_test.id
    component_id          = var.application_insights_id
    failed_location_count = length(var.web_test_geo_locations)
  }

  action {
    action_group_id = local.should_create_action_group ? azurerm_monitor_action_group.cpce_monitor_action_group[0].id : var.action_group_id
  }
}