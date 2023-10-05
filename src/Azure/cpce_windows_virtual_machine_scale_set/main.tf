locals {
  name = coalesce(var.name, lower(format("vmss%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
  host_name = coalesce(var.host_name, replace(lower(format("%s%s%s",
    var.customer_code != null ? var.customer_code : "",
    var.environment_code != null ? var.environment_code : "",
    var.host_name_suffix != null ? var.host_name_suffix : ""
  )), "-", ""))
  instance_size = coalesce(var.instance_size, local.default_instance_size)
  os_disk = {
    type      = coalesce(var.os_disk.type, local.default_disk_type)
    size_gb   = coalesce(var.os_disk.size_gb, local.default_os_disk_size_gb)
    ephemeral = coalesce(var.os_disk.ephemeral, local.default_os_disk_is_ephemeral)
  }
  key_vault_agent_required                 = (var.key_vault_agent != null)
  domain_join_agent_required               = var.domain_join_agent != null
  custom_script_extension_required         = var.custom_script_extension != null
  service_fabric_agent_required            = var.service_fabric_agent != null
  # dsc_agent_required                      = var.dsc_agent != null
  azure_devops_pool_agent_required         = var.azure_devops_pool_agent != null
  azure_devops_product_pool_agent_required = var.azure_devops_product_pool_agent != null
  user_assigned_managed_identity_name_principal_id = var.user_assigned_managed_identity_name != null ? data.azurerm_user_assigned_identity.user_assigned_managed_identity[0].principal_id : azurerm_user_assigned_identity.scale_set_identities[0].principal_id
}

locals {
  default_instance_size = lookup({
    DEV  = "Standard_D2_v2"
    TEST = "Standard_D2_v4"
    PROD = "Standard_DS2_v4"
  }, var.environment_quality, "Standard_DS_v2")

  default_disk_type = lookup({
    DEV  = "StandardSSD_LRS"
    TEST = "StandardSSD_LRS"
    PROD = "Premium_LRS"
  }, var.environment_quality, "Premium_LRS")

  default_os_disk_size_gb      = 128
  default_os_disk_is_ephemeral = false

  custom_script = "C:/Packages/Plugins/Microsoft.Compute.CustomScriptExtension/*/Downloads/*/RegisterDevOpsAgent.ps1 -EnvironmentName '${var.azure_devops_pool_agent.environment_name}' -AgentPool '${var.azure_devops_pool_agent.agent_pool}' -DevOpsOrganisation '${var.azure_devops_pool_agent.organisation}' -ProjectName '${var.azure_devops_pool_agent.team_project}' -PAT '${var.azure_devops_pool_agent_pat}' -AgentDemandTag '${var.azure_devops_pool_agent.agent_workload}' -AgentParentDirectory azagent ; C:/Packages/Plugins/Microsoft.Compute.CustomScriptExtension/*/Downloads/*/RegisterDevOpsAgent.ps1 -EnvironmentName '${var.azure_devops_product_pool_agent.environment_name}.product' -AgentPool '${var.azure_devops_product_pool_agent.agent_pool}' -DevOpsOrganisation '${var.azure_devops_product_pool_agent.organisation}' -ProjectName '${var.azure_devops_product_pool_agent.team_project}' -PAT '${var.azure_devops_pool_agent_pat}' -AgentDemandTag '${var.azure_devops_product_pool_agent.agent_workload}' -AgentParentDirectory azagent-product -AgentNameSuffix product"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "local_admin_password_secret" {
  name         = "${local.name}-local-admin-password"
  value        = var.local_admin_password
  key_vault_id = var.local_admin_password_key_vault_id
  content_type = "VMSS Admin Password"
  tags         = { managed_by_terraform = true }
}

# If a User Assigned Managed Identity is to be used for this VMSS, get its details
data "azurerm_user_assigned_identity" "user_assigned_managed_identity" {
  count               = var.user_assigned_managed_identity_name != null ? 1 : 0
  name                = var.user_assigned_managed_identity_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "scale_set_identities" {
  count               = var.user_assigned_managed_identity_name == null ? 1 : 0

  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "id-${local.name}"
  tags = var.tags
}

resource "azurerm_role_assignment" "vm_storage_account_state_configuration" {
  count                 = var.enable_state_configuration_access == true ? 1 : 0

  scope                 = var.state_configuration_storage_account_id
  principal_id          = azurerm_user_assigned_identity.scale_set_identities[0].principal_id
  role_definition_name  = "Storage Blob Data Reader"
}

resource "azurerm_role_assignment" "user_assigned_managed_identity_key_vault_secrets_role_assignment" {
  for_each             = var.cluster_certificates
  scope                = "${var.key_vault_agent.key_vault_id}/secrets/${var.cluster_certificates[each.key].name}"
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.scale_set_identities[0].principal_id
}

resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  resource_group_name      = var.resource_group_name
  location                 = var.location
  name                     = local.name
  computer_name_prefix     = local.host_name
  sku                      = local.instance_size
  instances                = var.instance_count
  admin_username           = var.local_admin_username
  admin_password           = var.local_admin_password
  zones                    = var.zones
  zone_balance             = var.zones != null
  overprovision            = false
  upgrade_mode             = var.upgrade_mode # how changes to the VMSS model are rolled out to the instances
  enable_automatic_updates = false            # whether or not the OS should be patched at runtime using Windows Update

  source_image_reference {
    publisher = var.windows_image_publisher
    offer     = var.windows_image_offer
    sku       = var.windows_image_sku
    version   = "latest"
  }

  # For ephemeral OS Disks, diff_disk_settings.option must be set to 'Local' and caching set to 'ReadOnly'
  dynamic "os_disk" {
    for_each = local.os_disk.ephemeral ? [1] : []
    content {
      storage_account_type = local.os_disk.type
      disk_size_gb         = local.os_disk.size_gb
      caching              = "ReadOnly"
      diff_disk_settings {
        option = "Local"
      }
    }
  }
  # For non-ephemeral OS Disks, diff_disk_settings must be excluded and caching set to 'ReadWrite'
  dynamic "os_disk" {
    for_each = local.os_disk.ephemeral ? [] : [1]
    content {
      storage_account_type = local.os_disk.type
      disk_size_gb         = local.os_disk.size_gb
      caching              = "ReadWrite"
    }
  }

  dynamic "data_disk" {
    for_each = var.data_disks

    content {
      disk_size_gb         = each.value.size_gb
      storage_account_type = each.value.type != null ? each.value.type : local.default_disk_type
      lun                  = each.value.lun
      create_option        = "Empty"
      caching              = each.value.caching != null ? each.value.caching : "ReadWrite"
    }
  }

  network_interface {
    name                          = "${local.name}-nic"
    primary                       = true
    enable_accelerated_networking = var.nic.enable_accelerated_networking
    ip_configuration {
      name                                         = "${local.name}-nic-primary"
      primary                                      = true
      subnet_id                                    = var.nic.subnet_id
      application_gateway_backend_address_pool_ids = var.nic.application_gateway_backend_address_pool_ids
      load_balancer_backend_address_pool_ids       = var.nic.load_balancer_backend_address_pool_ids
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = var.user_assigned_managed_identity_name != null ? [data.azurerm_user_assigned_identity.user_assigned_managed_identity[0].id] : [azurerm_user_assigned_identity.scale_set_identities[0].id]
  }

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = false # whether the instances should be automatically upgraded to the latest version of the OS image (when it becomes available)
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  additional_capabilities {
    ultra_ssd_enabled = false
  }

  # FACT:   If requested, the Service Fabric extension MUST be installed when the VMSS is provisioned. It cannot be done afterwards using an azurerm_virtual_machine_scale_set_extension resource.
  # FACT:   The Service Fabric extension will not succeed unless the Cluster/Reverse-Proxy certificates are already on the VMSS instance.
  # FACT:   The Service Fabric Cluster/Reverse-Proxy certificates are downloaded onto the VMSS instance by the KeyVaultForWindows extension.
  # IMPACT: We also need to provision KeyVaultForWindows extension as part of the VMSS provisioning as well.

  # FACT:   The KeyVaultForWindows extension uses the managed identity of the VMSS to download certificates that it's observing in KeyVault.
  # FACT:   We can't grant a _System Assigned_ Managed Identity any permissions to Key Vault until _after_ the VMSS has been provisioned.
  # IMPACT: All Service Fabric VMSS's will always have to operate under a _User Assigned_ Managed Identity

  # LogAnalyticsAgent
  extension {
    name                       = "LogAnalyticsAgent"
    publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
    type                       = "MicrosoftMonitoringAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true
    settings = jsonencode({
      workspaceId = var.log_analytics_workspace_id
    })
    protected_settings = jsonencode({
      workspaceKey = var.log_analytics_workspace_key
    })
  }

  # DependencyAgent
  extension {
    name                       = "DependencyAgent"
    publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
    type                       = "DependencyAgentWindows"
    type_handler_version       = "9.5"
    auto_upgrade_minor_version = true
  }

  # KeyVaultAgent
  dynamic "extension" {
    for_each = local.key_vault_agent_required ? [1] : []
    content {
      name                       = "KeyVaultAgent"
      publisher                  = "Microsoft.Azure.KeyVault"
      type                       = "KeyVaultForWindows"
      type_handler_version       = "1.0"
      auto_upgrade_minor_version = true
      settings = jsonencode({
        secretsManagementSettings = {
          pollingIntervalInS       = "900"
          certificateStoreName     = "My"
          certificateStoreLocation = "LocalMachine"
          linkOnRenewal            = var.key_vault_agent.link_certificates_on_renewal
          observedCertificates     = [for cert_name in var.key_vault_agent.observed_certificate_names : "https://${var.key_vault_agent.key_vault_name}.vault.azure.net/secrets/${cert_name}"]
          requireInitialSync       = true
        }
      })
    }
  }

  # CustomScriptExtension
  dynamic "extension" {
    for_each = local.custom_script_extension_required ? [1] : []
    content {
      name                       = "CustomScriptExtension"
      publisher                  = "Microsoft.Compute"
      type                       = "CustomScriptExtension"
      type_handler_version       = "1.9"
      auto_upgrade_minor_version = true
      settings = jsonencode({
        commandToExecute = "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(var.custom_script_extension.script_to_run)}')) | Out-File -filepath postBuild.ps1\" && powershell -ExecutionPolicy Unrestricted -File postBuild.ps1"
      })
      provision_after_extensions = [for dependency in [
        "LogAnalyticsAgent",
        "DependencyAgent",
        local.key_vault_agent_required ? "KeyVaultAgent" : null
      ] : dependency if dependency != null]
    }
  }

  # Agent extension for registering VM into an Agent Pool
  dynamic "extension" {
    for_each = local.azure_devops_pool_agent_required || local.azure_devops_product_pool_agent_required ? [1] : []
    content {
      name                 = "AzureDevOpsAgent"
      publisher            = "Microsoft.Compute"
      type                 = "CustomScriptExtension"
      type_handler_version = "1.9"
      protected_settings = <<PROTECTED_SETTINGS
        {
          "fileUris": ["${var.azure_devops_pool_agent.agent_script_url}"],
          "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(local.custom_script)}')) | Out-File -filepath postBuild.ps1\" && powershell -ExecutionPolicy Unrestricted -File postBuild.ps1",
          "managedIdentity": {
            "objectId": "${local.user_assigned_managed_identity_name_principal_id}"
          },
          "timestamp" : "12"
        }
PROTECTED_SETTINGS
      provision_after_extensions = [for dependency in [
        "LogAnalyticsAgent",
        "DependencyAgent",
        local.key_vault_agent_required ? "KeyVaultAgent" : null,
        local.custom_script_extension_required ? "CustomScriptExtension" : null
      ] : dependency if dependency != null]
    }
  }

  # JoinDomain
  dynamic "extension" {
    for_each = local.domain_join_agent_required ? [1] : []
    content {
      name                       = "JoinDomain"
      publisher                  = "Microsoft.Compute"
      type                       = "JsonADDomainExtension"
      type_handler_version       = "1.3"
      auto_upgrade_minor_version = true
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
      provision_after_extensions = [for dependency in [
        "LogAnalyticsAgent",
        "DependencyAgent",
        local.key_vault_agent_required ? "KeyVaultAgent" : null,
        local.custom_script_extension_required ? "CustomScriptExtension" : null,
        local.azure_devops_pool_agent_required ? "AzureDevOpsAgent" : null,
        # local.azure_devops_product_pool_agent_required ? "AzureDevOpsProductAgent" : null
      ] : dependency if dependency != null]
    }
  }

  # ServiceFabricNode
  dynamic "extension" {
    for_each = local.service_fabric_agent_required ? [1] : []
    content {
      name                       = "ServiceFabricNode"
      publisher                  = "Microsoft.Azure.ServiceFabric"
      type                       = "ServiceFabricNode"
      type_handler_version       = "1.1"
      auto_upgrade_minor_version = true
      settings = jsonencode({
        clusterEndpoint    = var.service_fabric_agent.cluster_endpoint
        nodeTypeRef        = var.service_fabric_agent.node_type
        dataPath           = var.service_fabric_agent.fabric_root_path
        durabilityLevel    = var.service_fabric_agent.durability_level
        nicPrefixOverride  = var.service_fabric_agent.nic_prefix_override
        enableParallelJobs = true
        certificate = {
          commonNames   = var.service_fabric_agent.cluster_certificate_common_names
          x509StoreName = "My"
        }
        reverseProxyCertificate = {
          commonNames   = var.service_fabric_agent.reverse_proxy_certificate_common_names != null ? var.service_fabric_agent.reverse_proxy_certificate_common_names : []
          x509StoreName = "My"
        }
      })
      protected_settings = jsonencode({
        StorageAccountKey1 = var.service_fabric_agent_log_storage_account_keys.primary_access_key
        StorageAccountKey2 = var.service_fabric_agent_log_storage_account_keys.secondary_access_key
      })
      provision_after_extensions = [for dependency in [
        "LogAnalyticsAgent",
        "DependencyAgent",
        local.key_vault_agent_required ? "KeyVaultAgent" : null,
        local.custom_script_extension_required ? "CustomScriptExtension" : null,
        local.domain_join_agent_required ? "JoinDomain" : null,
        # local.dsc_agent_required ? "DscAgent" : null
      ] : dependency if dependency != null]
    }
  }

  # depends_on = [
  #   azurerm_role_assignment.user_assigned_managed_identity_key_vault_secrets_role_assignment,
  #   azurerm_user_assigned_identity.scale_set_identities,
  #   azurerm_role_assignment.vm_storage_account_state_configuration
  # ]

  tags = merge({
    role                 = var.role,
    environment          = var.environment_code,
    managed_by_terraform = true
  }, var.tags)
}

resource "azurerm_virtual_machine_scale_set_extension" "IaaSAntimalwareAgent" {
  count = var.disable_iaas_extension ? 1 : 0
  depends_on = [
    azurerm_windows_virtual_machine_scale_set.vmss
  ]
  name                         = "IaaSAntimalwareAgent"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Azure.Security"
  type                         = "IaaSAntimalware"
  type_handler_version         = "1.3"
  settings = jsonencode({
    AntimalwareEnabled = true
    Exclusions = {
      Extensions = join(";", var.iaas_antimalware_agent.exclusions.extensions)
      Paths      = join(";", var.iaas_antimalware_agent.exclusions.paths)
      Processes  = join(";", var.iaas_antimalware_agent.exclusions.processes)
    }
    RealtimeProtectionEnabled = true
    ScheduledScanSettings = {
      isEnabled = var.iaas_antimalware_agent.scheduled_scan.enabled
      scanType  = "Quick"
      day       = "7",
      time      = "120"
    }
  })
}
