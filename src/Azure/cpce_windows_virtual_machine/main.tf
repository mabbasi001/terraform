locals {
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  size                                 = var.size != null ? var.size : local.default_size
  role                                 = var.role
  nics                                 = var.nics
  windows_image_publisher              = var.windows_image_publisher
  windows_image_offer                  = var.windows_image_offer
  windows_image_sku                    = var.windows_image_sku
  local_admin_username                 = var.local_admin_username
  local_admin_password                 = var.local_admin_password
  os_disk_type                         = var.os_disk_type != null ? var.os_disk_type : local.default_disk_type
  os_disk_size_gb                      = var.os_disk_size_gb
  timezone                             = var.timezone
  availability_set_id                  = var.availability_set_id
  availability_zone_id                 = var.availability_zone_id
  encryption_at_host_enabled           = var.encryption_at_host_enabled
  boot_diagnostics_storage_account_uri = var.boot_diagnostics_storage_account_uri
  recovery_vault_name                  = var.recovery_vault_name
  backup_policy_id                     = var.backup_policy_id
  rsv_resource_group_name              = var.rsv_resource_group_name != null ? var.rsv_resource_group_name : local.resource_group_name
  vm_environment_code                  = coalesce(var.short_environment_code, var.environment_code)
  azure_devops_pool_agent_required         = var.azure_devops_pool_agent != null
  azure_devops_product_pool_agent_required = var.azure_devops_product_pool_agent != null

  name = var.name != null ? var.name : lower(format("vm%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  ))

  host_name = var.host_name != null ? var.host_name : replace(lower(format("%s%s%s",
    coalesce(var.customer_code, ""),
    coalesce(local.vm_environment_code, ""),
    coalesce(var.name_suffix, "")
  )), "-", "")
}

locals {
  default_size = lookup({
    DEV  = "Standard_B2s"
    TEST = "Standard_D2s_v4"
    PROD = "Standard_D2s_v4"
  }, var.environment_quality, "Standard_D2s_v4")

  default_disk_type = lookup({
    DEV  = "StandardSSD_LRS"
    TEST = "StandardSSD_LRS"
    PROD = "Premium_LRS"
  }, var.environment_quality, "Premium_LRS")

  patch_mode = lookup({
    DEV  = "AutomaticByOS"
    TEST = "AutomaticByOS"
    PROD = "Manual"
  }, var.environment_quality, "Manual")

  custom_script = "C:/Packages/Plugins/Microsoft.Compute.CustomScriptExtension/*/Downloads/*/RegisterDevOpsAgent.ps1 -EnvironmentName '${var.azure_devops_pool_agent.environment_name}' -AgentPool '${var.azure_devops_pool_agent.agent_pool}' -DevOpsOrganisation '${var.azure_devops_pool_agent.organisation}' -ProjectName '${var.azure_devops_pool_agent.team_project}' -PAT '${var.azure_devops_deployment_group_agent_pat}' -AgentDemandTag '${var.azure_devops_pool_agent.agent_workload}' -AgentParentDirectory azagent ; C:/Packages/Plugins/Microsoft.Compute.CustomScriptExtension/*/Downloads/*/RegisterDevOpsAgent.ps1 -EnvironmentName '${var.azure_devops_product_pool_agent.environment_name}.product' -AgentPool '${var.azure_devops_product_pool_agent.agent_pool}' -DevOpsOrganisation '${var.azure_devops_product_pool_agent.organisation}' -ProjectName '${var.azure_devops_product_pool_agent.team_project}' -PAT '${var.azure_devops_deployment_group_agent_pat}' -AgentDemandTag '${var.azure_devops_product_pool_agent.agent_workload}' -AgentParentDirectory azagent-product -AgentNameSuffix product"
}

# prefix disks and nics with VM name so all VM resources get grouped together
module "cpce_vm_nics" {
  source   = "../cpce_network_interface"
  for_each = { for nic in local.nics : nic.index => nic }

  resource_group_name           = local.resource_group_name
  location                      = local.location
  name                          = format("%s-nic-%02d", local.name, each.key)
  subnet_id                     = each.value.subnet_id
  private_ip_address_allocation = each.value.private_ip_address_allocation
  private_ip_address            = each.value.private_ip_address
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                       = local.name
  location                   = local.location
  resource_group_name        = local.resource_group_name
  size                       = local.size
  network_interface_ids      = [for nic in module.cpce_vm_nics : nic.id]
  availability_set_id        = local.availability_set_id == "" ? null : local.availability_set_id
  zone                       = local.availability_zone_id
  timezone                   = local.timezone
  patch_mode                 = local.patch_mode
  enable_automatic_updates   = local.patch_mode == "Manual" ? false : true
  admin_username             = local.local_admin_username
  admin_password             = local.local_admin_password
  computer_name              = local.host_name
  provision_vm_agent         = true
  encryption_at_host_enabled = local.encryption_at_host_enabled
  tags = merge({
    role                 = local.role
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)

  source_image_reference {
    publisher = local.windows_image_publisher
    offer     = local.windows_image_offer
    sku       = local.windows_image_sku
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = local.os_disk_type
    name                 = "${local.name}-osdisk"
    disk_size_gb         = local.os_disk_size_gb
  }

  identity {
    type         = var.user_assigned_managed_identity_id == null ? "SystemAssigned" : "UserAssigned"
    identity_ids = var.user_assigned_managed_identity_id == null ? [] : [var.user_assigned_managed_identity_id]
  }

  boot_diagnostics {
    storage_account_uri = local.boot_diagnostics_storage_account_uri
  }
}

resource "azurerm_managed_disk" "managed_data_disks" {
  for_each = var.data_disks

  resource_group_name  = local.resource_group_name
  location             = local.location
  name                 = format("%s-disk-%02d", local.name, each.key)
  storage_account_type = each.value.type != null ? each.value.type : local.os_disk_type
  create_option        = "Empty"
  disk_size_gb         = each.value.size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each = var.data_disks

  managed_disk_id    = azurerm_managed_disk.managed_data_disks[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = each.value.lun
  # Only Disk Caching Type 'None' is supported for disks of size 4096 GB or greater
  caching = each.value.caching != null ? each.value.caching : (each.value.size_gb >= 4096 ? "None" : "ReadWrite")
}

# This is to allow time for WMI to get ready. See #234962 for more details.
resource "time_sleep" "extensions_creation_delay" {
  depends_on      = [azurerm_windows_virtual_machine.vm]
  create_duration = var.extensions_creation_delay
}

resource "azurerm_virtual_machine_extension" "iaas_antimalware_agent" {
  name                       = "IaaSAntimalwareAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }
  settings = jsonencode({
    AntimalwareEnabled = true,
    Exclusions = {
      Extensions = join(";", var.iaas_antimalware.exclusions.extensions)
      Paths      = join(";", var.iaas_antimalware.exclusions.paths)
      Processes  = join(";", var.iaas_antimalware.exclusions.processes)
    }
    RealtimeProtectionEnabled = true
    ScheduledScanSettings = {
      isEnabled = var.iaas_antimalware.scheduled_scan.enabled
      scanType  = "Quick",
      day       = "7",
      time      = "120"
    }
  })

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

resource "azurerm_virtual_machine_extension" "log_analytics_agent" {
  name                       = "LogAnalyticsAgent"
  count                      = var.disable_log_analytics ? 0 : 1
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }
  settings = jsonencode({
    workspaceId = var.log_analytics_workspace_id
  })
  protected_settings = jsonencode({
    workspaceKey = var.log_analytics_workspace_key
  })

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

resource "azurerm_virtual_machine_extension" "dependency_agent" {
  name                       = "DependencyAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

resource "azurerm_virtual_machine_extension" "azure_policy_for_windows_agent" {
  name                       = "AzurePolicyforWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.1"
  auto_upgrade_minor_version = "true"
  automatic_upgrade_enabled  = true
  tags                       = { managed_by_terraform = true }

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

resource "azurerm_virtual_machine_extension" "azure_devops_deployment_group_agent" {
  count = var.azure_devops_deployment_group_agent == null ? 0 : 1

  name                       = "AzureDevopsDeploymentGroupAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.VisualStudio.Services"
  type                       = "TeamServicesAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }
  settings = jsonencode({
    VSTSAccountName = var.azure_devops_deployment_group_agent.organisation
    TeamProject     = var.azure_devops_deployment_group_agent.team_project
    DeploymentGroup = var.azure_devops_deployment_group_agent.deployment_group
    AgentName       = local.name
    Tags            = var.azure_devops_deployment_group_agent.tags
  })
  protected_settings = jsonencode({
    PATToken = var.azure_devops_deployment_group_agent_pat
  })

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

# Agent extension for registering VM into an Agent Pool
resource "azurerm_virtual_machine_extension" "azure_devops_pool_agent" {
  count = local.azure_devops_pool_agent_required || local.azure_devops_product_pool_agent_required ? 1 : 0

  name                 = "AzureDevOpsAgent"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "fileUris": ["${var.azure_devops_pool_agent.agent_script_url}"],
      "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(local.custom_script)}')) | Out-File -filepath postBuild.ps1\" && powershell -ExecutionPolicy Unrestricted -File postBuild.ps1",
      "managedIdentity": {},
      "timestamp" : "12"
    }
PROTECTED_SETTINGS

  depends_on = [
    time_sleep.extensions_creation_delay,
    azurerm_role_assignment.vm_storage_account_state_configuration
  ]
}

# Domain Join VM
resource "azurerm_virtual_machine_extension" "vm_domain_join_agent" {
  count = var.domain_join_agent == null ? 0 : 1

  name                 = "JoinDomain"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  settings = jsonencode({
    Name    = var.domain_join_agent.domain
    User    = var.domain_join_agent.domain_admin_username
    OUPath  = var.domain_join_agent.ou_path
    Restart = true
    Options = 3
  })
  protected_settings = jsonencode({
    Password = var.domain_admin_password
  })

  depends_on = [
    time_sleep.extensions_creation_delay,
    azurerm_virtual_machine_extension.azure_devops_pool_agent,
  ]

  # depends_on = [for dependency in [
  #   time_sleep.extensions_creation_delay,
  #   var.azure_devops_pool_agent ? azurerm_virtual_machine_extension.azure_devops_pool_agent : null,
  #   var.azure_devops_product_pool_agent ? azurerm_virtual_machine_extension.azure_devops_product_pool_agent : null
  # ] : dependency if dependency != null]
}

# Grant the VM's system identity to the SA containing configuration assets
resource "azurerm_role_assignment" "vm_storage_account_state_configuration" {
  count                 = var.enable_state_configuration_access == true ? 1 : 0

  scope                 = var.state_configuration_storage_account_id
  principal_id          = azurerm_windows_virtual_machine.vm.identity[0].principal_id
  role_definition_name  = "Storage Blob Data Reader"
}

# Grant the VM Identity permission to access all the certificates that it needs to observe
resource "azurerm_role_assignment" "vm_key_vault_role_assigment" {
  for_each             = { for cert in var.key_vault_agent.observed_certificates : "${cert.key_vault_id}/secrets/${cert.certificate_name}" => cert }
  scope                = each.key
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_windows_virtual_machine.vm.identity[0].principal_id
}

# The KeyVaultForWindows extension will observe certificates in Key Vault and download any
# new versions automatically
resource "azurerm_virtual_machine_extension" "key_vault_agent" {
  count = length(var.key_vault_agent.observed_certificates) == 0 ? 0 : 1

  name                       = "KeyVaultAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.KeyVault"
  type                       = "KeyVaultForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }
  settings = jsonencode({
    secretsManagementSettings = {
      pollingIntervalInS       = "900"
      certificateStoreName     = "My"
      certificateStoreLocation = "LocalMachine"
      linkOnRenewal            = var.key_vault_agent.link_certificates_on_renewal
      observedCertificates     = [for cert in var.key_vault_agent.observed_certificates : "https://${cert.key_vault_name}.vault.azure.net/secrets/${cert.certificate_name}"]
    }
  })

  depends_on = [
    time_sleep.extensions_creation_delay
  ]
}

resource "azurerm_virtual_machine_extension" "connect_to_avd_pool" {
  count = var.connect_to_avd_pool == null ? 0 : 1

  name                       = "connect_to_avd_pool"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true
  tags                       = { managed_by_terraform = true }
  settings = jsonencode({
    "modulesUrl" : "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip",
    "configurationFunction" : "Configuration.ps1\\AddSessionHost",
    "properties" : {
      "hostPoolName" : "${var.avd_host_pool_name}",
      "registrationInfoToken" : "${var.avd_host_pool_token}"
    }
  })

  lifecycle {
    ignore_changes = [settings]
  }

  depends_on = [
    time_sleep.extensions_creation_delay,
    azurerm_virtual_machine_extension.vm_domain_join_agent,
    azurerm_virtual_machine_extension.iaas_antimalware_agent
  ]
}
