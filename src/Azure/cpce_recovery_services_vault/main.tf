locals {
  name = var.name != null ? var.name : lower(format("rsv%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))
}

resource "azurerm_recovery_services_vault" "cpce_recovery_services_vault" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = local.name
  sku                 = coalesce(var.sku, "Standard")
  soft_delete_enabled = var.environment_quality == "PROD"
  tags                = merge({ managed_by_terraform = true }, var.tags)

  provisioner "local-exec" {
    when        = destroy
    command     = <<-COMMAND
      # Wait for deleted items to propagate. Fix for "Recovery Services Vault cannot be deleted as there are existing resources within the vault" error. 
      Start-Sleep -Seconds 180
      COMMAND
    interpreter = ["PowerShell", "-Command"]
    on_failure  = fail
  }
}
