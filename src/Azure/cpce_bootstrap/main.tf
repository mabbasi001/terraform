data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}


resource "azurerm_resource_group" "bootstrap" {
  name     = "rg-${var.name_suffix}-${var.environment_code}"
  location = var.location
  tags     = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_virtual_network" "bootstrap" {
  name                = "vnet-${var.name_suffix}-${var.environment_code}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.bootstrap.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  tags                = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_subnet" "bootstrap" {
  name                 = "snet-${var.name_suffix}-${var.environment_code}"
  resource_group_name  = azurerm_resource_group.bootstrap.name
  virtual_network_name = azurerm_virtual_network.bootstrap.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_network_security_group" "bootstrap" {
  name                = "nsg-${var.name_suffix}-${var.environment_code}"
  location            = azurerm_resource_group.bootstrap.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  tags                = merge({ managed_by_terraform = true }, var.tags)
  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "bootstrap" {
  subnet_id                 = azurerm_subnet.bootstrap.id
  network_security_group_id = azurerm_network_security_group.bootstrap.id
}

resource "azurerm_storage_account" "bootstrap" {
  name                     = "sa${var.name_suffix}${var.environment_code}"
  resource_group_name      = azurerm_resource_group.bootstrap.name
  location                 = azurerm_resource_group.bootstrap.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_storage_container" "tf-state" {
  name                  = "tf-state"
  storage_account_name  = azurerm_storage_account.bootstrap.name
  container_access_type = "private"
}

data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
}


######################################################
#KV
#########################################################

resource "azurerm_key_vault" "key_vault" {
  name                = "kv-${var.name_suffix}-${var.environment_code}"
  location            = azurerm_resource_group.bootstrap.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
  tags                = merge({ managed_by_terraform = true }, var.tags)
}

resource "azurerm_key_vault_access_policy" "current" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  key_permissions = [
    "Get", "List", "Create", "Delete", "Update"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]
  certificate_permissions = [
    "Get", "List", "Delete", "Update", "Import", "Create", "Purge", "Restore", "Backup", "Recover"
  ]
    depends_on = [
    azurerm_key_vault.key_vault
  ]
}
resource "azurerm_key_vault_access_policy" "sp" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuread_application.application.application_id
  key_permissions = [
    "Get", "List", "Create", "Delete", "Update"
  ]
  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]
  certificate_permissions = [
    "Get", "List", "Delete", "Update", "Import", "Create", "Purge", "Restore", "Backup", "Recover"
  ]
    depends_on = [
    azurerm_key_vault.key_vault
  ]
}



######################################################
#KV Secret
######################################################

resource "azurerm_key_vault_secret" "ClientId" {
  name         = "ClientId"
  value        = azuread_application.application.application_id
  key_vault_id = azurerm_key_vault.key_vault.id
  tags                = merge({ managed_by_terraform = true }, var.tags)
  depends_on = [
  azurerm_key_vault.key_vault,
  azuread_application.application,
  azurerm_key_vault_access_policy.current
  ]
}

resource "azurerm_key_vault_secret" "ClientSecret" {
  name         = "ClientSecret"
  value        = azuread_application_password.application_password.value
  key_vault_id = azurerm_key_vault.key_vault.id
  tags                = merge({ managed_by_terraform = true }, var.tags)
  depends_on = [
  azurerm_key_vault.key_vault,
  azuread_application_password.application_password,
  azurerm_key_vault_access_policy.current
  ]
}

###############################################################################
#                   Create App Registration and Secret                        #
###############################################################################
resource "azuread_application" "application" {
  display_name = "${data.azurerm_subscription.current.display_name}-Owner"
  owners       = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  api {    
	requested_access_token_version = 2
  }
  # required_resource_access {
  #   resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

  #   resource_access {
  #     id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
  #     type = "Scope"
  #   }
  # }
}

resource "azuread_service_principal" "service_principal" {
  application_id               = azuread_application.application.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "application_password" {
  application_object_id = azuread_application.application.object_id
  #end_date_relative = "96h"
}


resource "azurerm_role_assignment" "owner" {
  scope = data.azurerm_subscription.current.id
  role_definition_name = "Owner"
  principal_id = azuread_service_principal.service_principal.id
}