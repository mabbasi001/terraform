resource "azurerm_monitor_action_group" "cpce_monitor_action_group_ignore_email" {
  count = var.ignore_email_changes ? 1 : 0

  name                = azurecaf_name.azurerm_monitor_action_group.result
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

  lifecycle {
    ignore_changes = [
      email_receiver
    ]
  }

  tags = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_monitor_action_group" "cpce_monitor_action_group" {
  count = var.ignore_email_changes ? 0 : 1

  name                = azurecaf_name.azurerm_monitor_action_group.result
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

  tags = merge({ managed_by_terraform = true }, var.tags)
}