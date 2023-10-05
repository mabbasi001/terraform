locals {
  name = coalesce(var.name, lower(format("sf%s%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.environment_location_short_code != null ? "-${var.environment_location_short_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))

  host_name = var.host_name != null ? var.host_name : var.targets_secondary_region != true ? lower(format("%s%ssf",
    coalesce(var.customer_code, ""),
    coalesce(local.vm_environment_code, "")
    )) : lower(format("%s%ssf",
    coalesce(local.vm_environment_code, ""),
    var.environment_location_short_code != null ? var.environment_location_short_code : ""
  ))

  service_fabric_cluster_explorer_uri = format("https://%s:%s", var.cluster_management_uri, coalesce(var.internal_load_balancer.http_administration_gateway_port, local.default_http_administration_gateway_port))

  service_fabric_cluster_app_reg_display_name = coalesce(var.service_fabric_cluster_app_reg_display_name, format("%s%s%s Service Fabric Cluster",
    var.customer_code != null ? upper(var.customer_code) : "",
    var.environment_code != null ? upper(" ${var.environment_code}") : "",
    var.targets_secondary_region == true && var.environment_location_short_code != null ? upper(" ${var.environment_location_short_code}") : ""
  ))

  service_fabric_client_app_reg_display_name = coalesce(var.service_fabric_client_app_reg_display_name, format("%s%s Service Fabric Client",
    var.customer_code != null ? upper(var.customer_code) : "",
    var.environment_code != null ? upper(" ${var.environment_code}") : ""
  ))

  vm_environment_code          = var.short_environment_code != null ? var.short_environment_code : var.environment_code
  fabric_application_root_path = "C:\\SvcFab"

  default_tcp_administration_gateway_port  = 19000
  default_http_administration_gateway_port = 19080
  default_reverse_proxy_gateway_port       = 443

  default_reliability_level = lookup({
    DEV  = "None"
    TEST = "Bronze"
    PROD = "Silver"
  }, var.environment_quality, "Silver")

  default_node_type_instance_count = lookup({
    DEV  = 1
    TEST = 3
    PROD = 5
  }, var.environment_quality, 5)

  default_node_type_instance_size = lookup({
    DEV  = "Standard_D2_v2"
    TEST = "Standard_D2s_v4"
    PROD = "Standard_D4s_v4"
  }, var.environment_quality, "Standard_D4s_v4")

  default_node_type_durability_level = lookup({
    DEV  = "Bronze"
    TEST = "Bronze"
    PROD = "Silver"
  }, var.environment_quality, "Bronze")

  default_node_type_application_ports = {
    start_port = 20000
    end_port   = 30000
  }

  default_node_type_ephemeral_ports = {
    start_port = 49152
    end_port   = 65534
  }

  default_node_type_timezone = "UTC"

  default_upgrade_mode = "Manual"
}

resource "azurerm_key_vault_certificate" "cluster_certificates" {
  for_each     = var.cluster_certificates
  name         = "${local.name}-${each.key}"
  key_vault_id = var.key_vault.id

  certificate {
    contents = filebase64(each.value.pfx_path)
    password = var.cluster_certificate_pfx_passwords[each.key] # This assumes both maps contain the same keys
  }

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }

    key_properties {
      exportable = true
      key_size   = each.value.key_size
      key_type   = each.value.key_type
      reuse_key  = false
    }

    lifetime_action {
      action {
        action_type = "EmailContacts"
      }
      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    fabric_cluster       = local.name
    certificate_type     = each.value.type
    managed_by_terraform = true
  }, var.tags)
}

module "internal_load_balancer" {
  source                        = "../cpce_load_balancer"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  name                          = "lb-${local.name}"
  sku_name                      = var.internal_load_balancer.sku_name # Basic SKU load balancers aren't supported on subnets containing NAT Gateways
  subnet_id                     = var.internal_load_balancer.subnet_id
  private_ip_address            = var.internal_load_balancer.private_ip_address
  private_ip_address_allocation = "Static"
  zones                         = var.targets_secondary_region == true ? null : [ "1", "2", "3" ]

  lb_rules = {
    lbrule_fabric_tcp_gateway = {
      frontend_port  = coalesce(var.internal_load_balancer.tcp_administration_gateway_port, local.default_tcp_administration_gateway_port)
      backend_port   = var.tcp_administration_endpoint_port
      probe_port     = var.tcp_administration_endpoint_port
      probe_protocol = "Tcp"
      request_path   = null
    }
    lbrule_fabric_http_gateway = {
      frontend_port  = coalesce(var.internal_load_balancer.http_administration_gateway_port, local.default_http_administration_gateway_port)
      backend_port   = var.http_administration_endpoint_port
      probe_port     = var.http_administration_endpoint_port
      probe_protocol = "Tcp"
      request_path   = null
    }
    lbrule_reverse_proxy_gateway = {
      frontend_port  = coalesce(var.internal_load_balancer.reverse_proxy_gateway_port, local.default_reverse_proxy_gateway_port)
      backend_port   = var.reverse_proxy_endpoint_port
      probe_port     = var.reverse_proxy_endpoint_port
      probe_protocol = "Tcp"
      request_path   = null
    }
  }
  tags = merge({
    fabric_cluster       = local.name
    managed_by_terraform = true
  }, var.tags)
}

module "fabric_logs_storage_account" {
  source                   = "../cpce_storage_account"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  name                     = replace("sa${local.name}logs", "-", "")
  environment_quality      = var.environment_quality
  account_replication_type = "LRS"
  enable_threat_protection = var.enable_threat_protection
  tags = merge({
    fabric_cluster       = local.name
    managed_by_terraform = true
  }, var.tags)
}

resource "random_uuid" "service_fabric_cluster_user_impersonation_scope_id" {}
resource "random_uuid" "service_fabric_cluster_user_role_id" {}
resource "random_uuid" "service_fabric_cluster_admin_role_id" {}

# <<<<<<< HEAD
# # to be checked
# # fix for issue error: Request_BadRequest: Another object with the same value for property
# resource "random_string" "random_suffix_azApp" {
#   length = 4
#   special = false
# }
# resource "azuread_application" "service_fabric_cluster" {
#   display_name     = "${local.service_fabric_cluster_app_reg_display_name}_${random_string.random_suffix_azApp.result}" # added a suffix to the name to avaid dublication
# =======
resource "azuread_application" "service_fabric_cluster" {
  count            = var.deploy_sf_azure_ad_app ? 1 : 0
  display_name     = local.service_fabric_cluster_app_reg_display_name
  identifier_uris  = ["https://${var.cluster_management_uri}"]
  sign_in_audience = "AzureADMyOrg"

  web {
    homepage_url  = "${local.service_fabric_cluster_explorer_uri}/Explorer/index.html"
    redirect_uris = ["${local.service_fabric_cluster_explorer_uri}/Explorer/index.html"]

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }

  api {
    requested_access_token_version = 2
    oauth2_permission_scope {
      id                         = random_uuid.service_fabric_cluster_user_impersonation_scope_id.result
      type                       = "User"
      value                      = "user_impersonation"
      admin_consent_display_name = "Access the ${local.service_fabric_cluster_app_reg_display_name}"
      admin_consent_description  = "Allows the application to access the ${local.service_fabric_cluster_app_reg_display_name} on behalf of the signed-in user"
      user_consent_display_name  = "Access the ${local.service_fabric_cluster_app_reg_display_name}"
      user_consent_description   = "Allows the application to access the ${local.service_fabric_cluster_app_reg_display_name} on your behalf"
      enabled                    = true
    }
  }

  app_role {
    id                   = random_uuid.service_fabric_cluster_user_role_id.result
    value                = "User"
    display_name         = "ReadOnly"
    description          = "ReadOnly roles have limited query access"
    allowed_member_types = ["User"]
    enabled              = true
  }

  app_role {
    id                   = random_uuid.service_fabric_cluster_admin_role_id.result
    value                = "Admin"
    display_name         = "Admin"
    description          = "Admins can manage roles and perform all task actions"
    allowed_member_types = ["User"]
    enabled              = true
  }

  required_resource_access {
    resource_app_id = "00000002-0000-0000-c000-000000000000"
    resource_access {
      id   = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"
      type = "Scope"
    }
  }
}

data "azuread_application" "service_fabric_cluster" {
  count            = var.deploy_sf_azure_ad_app ? 0 : 1
  display_name     = local.service_fabric_cluster_app_reg_display_name
}

resource "azuread_service_principal" "service_fabric_cluster" {
  count                        = var.deploy_sf_azure_ad_app ? 1 : 0
  application_id               = azuread_application.service_fabric_cluster[0].application_id
  app_role_assignment_required = true
}

resource "azuread_application" "service_fabric_client" {
  count        = var.deploy_sf_azure_ad_app ? 1 : 0
  display_name = local.service_fabric_client_app_reg_display_name

  public_client {
    redirect_uris = ["urn:ietf:wg:oauth:2.0:oob"]
  }

  required_resource_access {
    resource_app_id = "00000002-0000-0000-c000-000000000000"
    resource_access {
      id   = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"
      type = "Scope"
    }
  }
}

data "azuread_application" "service_fabric_client" {
  count        = var.deploy_sf_azure_ad_app ? 0 : 1
  display_name = local.service_fabric_client_app_reg_display_name
}

resource "azuread_service_principal" "service_fabric_client" {
  count          = var.deploy_sf_azure_ad_app ? 1 : 0
  application_id = azuread_application.service_fabric_client[0].application_id
}

resource "azuread_application_pre_authorized" "client_pre_authorized_to_cluster" {
  count                 = var.deploy_sf_azure_ad_app ? 1 : 0
  application_object_id = azuread_application.service_fabric_cluster[0].object_id
  authorized_app_id     = azuread_application.service_fabric_client[0].application_id
  permission_ids        = [random_uuid.service_fabric_cluster_user_impersonation_scope_id.result]
}

resource "azurerm_service_fabric_cluster" "cluster" {
  name                 = local.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  reliability_level    = coalesce(var.reliability_level, local.default_reliability_level)
  upgrade_mode         = var.upgrade_mode
  cluster_code_version = var.upgrade_mode == "Manual" ? var.cluster_version : null
  vm_image             = var.cluster_os_type
  management_endpoint  = format("https://%s:%s", var.cluster_management_uri, coalesce(var.internal_load_balancer.http_administration_gateway_port, local.default_http_administration_gateway_port))
  add_on_features      = ["RepairManager", "ResourceMonitorService"]

  # See https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-cross-availability-zones#enable-support-for-multiple-zones-in-the-service-fabric-node-type
  service_fabric_zonal_upgrade_mode = "Hierarchical"
  vmss_zonal_upgrade_mode           = "Parallel" # ARM does not support Hierarchical yet

  depends_on = [module.fabric_logs_storage_account]

  dynamic "certificate_common_names" {
    for_each = { for key, cert in var.cluster_certificates : key => cert if cert.type == "cluster" }
    content {
      common_names {
        certificate_common_name       = certificate_common_names.value.common_name
        certificate_issuer_thumbprint = certificate_common_names.value.issuer_thumbprint
      }
      x509_store_name = "My"
    }
  }

  dynamic "reverse_proxy_certificate_common_names" {
    for_each = { for key, cert in var.cluster_certificates : key => cert if cert.type == "reverse_proxy" }
    content {
      common_names {
        certificate_common_name = reverse_proxy_certificate_common_names.value.common_name
        # According to https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-create-cluster-using-cert-cn, it's best practice to set
        # the certificate_issuer_thumbprint. However, when we do, we get this error:
        #   "Issuer thumbprint is not supported for this particular certificate type yet"
        # certificate_issuer_thumbprint = reverse_proxy_certificate_common_names.value.issuer_thumbprint
      }
      x509_store_name = "My"
    }
  }

  azure_active_directory {
    tenant_id              = var.authentication_tenant_id
    cluster_application_id = var.deploy_sf_azure_ad_app ? azuread_application.service_fabric_cluster[0].application_id : data.azuread_application.service_fabric_cluster[0].application_id
    client_application_id  = var.deploy_sf_azure_ad_app ? azuread_application.service_fabric_client[0].application_id : data.azuread_application.service_fabric_client[0].application_id
  }

  dynamic "client_certificate_common_name" {
    for_each = var.client_certificates
    content {
      common_name       = client_certificate_common_name.value.common_name
      issuer_thumbprint = client_certificate_common_name.value.issuer_thumbprint
      is_admin          = client_certificate_common_name.value.is_admin
    }
  }

  diagnostics_config {
    storage_account_name       = module.fabric_logs_storage_account.name
    protected_account_key_name = "StorageAccountKey1"
    blob_endpoint              = module.fabric_logs_storage_account.primary_blob_endpoint
    queue_endpoint             = module.fabric_logs_storage_account.primary_queue_endpoint
    table_endpoint             = module.fabric_logs_storage_account.primary_table_endpoint
  }

  fabric_settings {
    name = "Security"
    parameters = {
      ClusterProtectionLevel = "EncryptAndSign"
    }
  }
  fabric_settings {
    name = "ClusterManager"
    parameters = {
      EnableDefaultServicesUpgrade = "true"
    }
  }
  fabric_settings {
    name = "ApplicationGateway/Http"
    parameters = {
      HttpRequestConnectTimeout     = "0.5"
      ResolveServiceBackoffInterval = "0"
    }
  }

  dynamic "node_type" {
    for_each = var.node_types
    content {
      name                 = node_type.key
      instance_count       = coalesce(node_type.value.instance_count, local.default_node_type_instance_count)
      is_primary           = node_type.value.is_primary
      placement_properties = coalesce(node_type.value.placement_properties, {})
      capacities           = coalesce(node_type.value.capacity_tags, {})
      durability_level     = coalesce(node_type.value.durability_level, local.default_node_type_durability_level)

      # See https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-cross-availability-zones#enable-support-for-multiple-zones-in-the-service-fabric-node-type
      multiple_availability_zones = coalesce(node_type.value.instance_count, local.default_node_type_instance_count) >= 15 && var.targets_secondary_region == false

      client_endpoint_port        = var.tcp_administration_endpoint_port
      http_endpoint_port          = var.http_administration_endpoint_port
      reverse_proxy_endpoint_port = var.reverse_proxy_endpoint_port
      application_ports {
        start_port = coalesce(node_type.value.application_ports, local.default_node_type_application_ports).start_port
        end_port   = coalesce(node_type.value.application_ports, local.default_node_type_application_ports).end_port
      }
      ephemeral_ports {
        start_port = coalesce(node_type.value.ephemeral_ports, local.default_node_type_ephemeral_ports).start_port
        end_port   = coalesce(node_type.value.ephemeral_ports, local.default_node_type_ephemeral_ports).end_port
      }
    }
  }

  tags = merge({
    customer             = var.customer_code
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)
}

/*resource "azurerm_role_assignment" "user_assigned_managed_identity_key_vault_certificates_role_assignment" {
  for_each             = azurerm_key_vault_certificate.cluster_certificates
  scope                = "${var.key_vault.id}/certificates/${azurerm_key_vault_certificate.cluster_certificates[each.key].name}"
  role_definition_name = "Key Vault Certificates Officer"
  #role_definition_id   = "a4417e6f-fecd-4de8-b567-7b0420556985"
  principal_id         = azurerm_user_assigned_identity.scale_set_identities["primary"].principal_id
}*/

module "scale_sets" {
  for_each = var.node_types

  source                              = "../cpce_windows_virtual_machine_scale_set"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  name                                = "vmss-${local.name}-${each.key}"
  environment_quality                 = var.environment_quality
  role                                = "service_fabric_cluster"
  host_name                           = local.host_name
  instance_size                       = coalesce(each.value.instance_size, local.default_node_type_instance_size)
  instance_count                      = coalesce(each.value.instance_count, local.default_node_type_instance_count)
  zones                               = coalesce(each.value.instance_count, local.default_node_type_instance_count) >= 15 && var.targets_secondary_region == false ? [1, 2, 3] : null
  timezone                            = coalesce(each.value.timezone, local.default_node_type_timezone)
  local_admin_password_key_vault_id   = var.key_vault.id
  local_admin_password                = var.vmss_local_admin_password
  user_assigned_managed_identity_name = var.user_assigned_managed_identity_name != null ? var.user_assigned_managed_identity_name : null
  upgrade_mode                        = "Automatic" # Service Fabric takes care of safely rolling out any changes to the VMSS model
  disable_iaas_extension              = var.disable_iaas_extension
  os_disk = {
    type    = each.value.os_disk == null ? null : each.value.os_disk.type
    size_gb = each.value.os_disk == null ? null : each.value.os_disk.size_gb
    # Note: Service Fabric would work really well with ephemeral disks! Unfortunately, windows server images are so
    # large that we would have to use a massive VM sku in order to have enough space in the VM cache to store the image.
    # When we move to linux images, we should revisit this though.
    ephemeral = false
  }
  nic = {
    subnet_id                                    = each.value.subnet.id
    load_balancer_backend_address_pool_ids       = [module.internal_load_balancer.backend_address_pool_id]
    application_gateway_backend_address_pool_ids = null
    enable_accelerated_networking                = each.value.enable_accelerated_networking
  }
  iaas_antimalware_agent = {
    exclusions = {
      extensions = []
      paths = [
        local.fabric_application_root_path,
        "${local.fabric_application_root_path}\\Log",
        "C:\\Program Files\\Microsoft Service Fabric",
        "%windir%\\SoftwareDistribution\\Datastore\\*\\tmp.edb",
        "%ProgramData%\\Microsoft\\Search\\Data\\Applications\\Windows\\*\\*.log",
        "%windir%\\SoftwareDistribution\\Datastore\\Datastore.edb",
        "%windir%\\SoftwareDistribution\\Datastore\\*\\edb.chk",
        ";%windir%\\SoftwareDistribution\\Datastore\\*\\edb*.log",
        "%windir%\\SoftwareDistribution\\Datastore\\*\\Edb*.jrs",
        "%windir%\\SoftwareDistribution\\Datastore\\*\\Res*.log",
        "%windir%\\Security\\database\\*.chk",
        "%windir%\\Security\\database\\*.edb",
        "%windir%\\Security\\database\\*.jrs",
        "%windir%\\Security\\database\\*.log",
        "%windir%\\Security\\database\\*.sdb",
        "%allusersprofile%\\NTUser.pol",
        "%SystemRoot%\\System32\\GroupPolicy\\Machine\\registry.pol",
        "%SystemRoot%\\System32\\GroupPolicy\\User\\registry.pol",
        "%systemroot%\\System32\\Wins\\*\\*.chk",
        "%systemroot%\\System32\\Wins\\*\\*.log",
        "%systemroot%\\System32\\Wins\\*\\*.mdb",
        "%systemroot%\\System32\\LogFiles\\",
        "%systemroot%\\SysWow64\\LogFiles\\",
        "%SystemRoot%\\IIS Temporary Compressed Files",
        "%SystemDrive%\\inetpub\\temp\\IIS Temporary Compressed Files",
        "%SystemDrive%\\inetpub\\temp\\ASP Compiled Templates",
        "%systemDrive%\\inetpub\\logs",
        "%systemDrive%\\inetpub\\wwwroot"
      ]
      processes = [
        "Fabric.exe",
        "FabricHost.exe",
        "FabricInstallerService.exe",
        "FabricSetup.exe",
        "FabricDeployer.exe",
        "ImageBuilder.exe",
        "FabricGateway.exe",
        "FabricDCA.exe",
        "FabricFAS.exe",
        "FabricUOS.exe",
        "FabricRM.exe",
        "FileStoreService.exe"
      ]
    }
    scheduled_scan = {
      enabled = true
    }
  }
  log_analytics_workspace_id  = var.log_analytics_workspace_id
  log_analytics_workspace_key = var.log_analytics_workspace_key
  key_vault_agent = {
    key_vault_name               = var.key_vault.name
    key_vault_id                 = var.key_vault.id
    observed_certificate_names   = [for key, val in var.cluster_certificates : "${local.name}-${key}"]
    link_certificates_on_renewal = false
  }
  cluster_certificates                   = azurerm_key_vault_certificate.cluster_certificates
  enable_state_configuration_access      = var.enable_state_configuration_access
  state_configuration_storage_account_id = var.enable_state_configuration_access == true ? var.state_configuration_storage_account_id : null
  domain_join_agent = var.windows_ad_domain == null ? null : {
    domain                = var.windows_ad_domain.domain
    domain_admin_username = "${var.windows_ad_domain.domain_admin_username}@${var.windows_ad_domain.domain}"
    ou_path               = format("OU=computers,OU=${lower(var.environment_code)},DC=${replace(lower(var.windows_ad_domain.domain), ".", ",DC=")}")
  }

  domain_admin_password       = var.domain_admin_password
  azure_devops_pool_agent_pat = var.azure_devops_pool_agent_pat
  azure_devops_pool_agent = {
    organisation     = var.azure_devops_organization
    team_project     = var.azure_devops_project
    environment_name = "${var.customer_code}-${var.environment_code}"
    agent_pool       = var.azure_devops_agent_pool_name
    agent_workload   = "ls-sf"
    agent_script_url = var.devops_agent_script_url
  }
  azure_devops_product_pool_agent = var.azure_devops_product_organization == null ? null : {
    organisation     = var.azure_devops_product_organization
    team_project     = var.azure_devops_product_project
    environment_name = "${var.customer_code}-${var.environment_code}"
    agent_pool       = var.azure_devops_product_agent_pool_name
    agent_workload   = "ls-sf"
    agent_script_url = var.devops_agent_script_url
  }
  service_fabric_agent = {
    node_type                              = each.key
    cluster_endpoint                       = azurerm_service_fabric_cluster.cluster.cluster_endpoint
    fabric_root_path                       = local.fabric_application_root_path
    durability_level                       = coalesce(each.value.durability_level, local.default_node_type_durability_level)
    nic_prefix_override                    = each.value.subnet.address_prefixes[0]
    cluster_certificate_common_names       = [for cert in var.cluster_certificates : cert.common_name if cert.type == "cluster"]
    reverse_proxy_certificate_common_names = [for cert in var.cluster_certificates : cert.common_name if cert.type == "reverse_proxy"]
  }
  service_fabric_agent_log_storage_account_keys = {
    primary_access_key   = module.fabric_logs_storage_account.primary_access_key
    secondary_access_key = module.fabric_logs_storage_account.secondary_access_key
  }
  tags = merge({
    fabric_cluster       = local.name
    node_type            = each.key
    managed_by_terraform = true
  }, var.tags)
  depends_on = [
    azurerm_key_vault_certificate.cluster_certificates,
  ]
}
