locals {
  resource_group_name = coalesce(var.resource_group_name, lower(format("rg%s%s%s",
    var.instance_code != null ? "-${var.instance_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))

  name = coalesce(var.name, lower(format("aadds%s%s%s",
    var.instance_code != null ? "-${var.instance_code}": "",
    var.environment_code != null ? "-${var.environment_code}" : "",
    var.name_suffix != null ? "-${var.name_suffix}" : ""
  )))
}

resource "azurerm_active_directory_domain_service" "aadds" {
  name                  = local.name
  location              = var.location
  resource_group_name   = local.resource_group_name
  sku                   = var.sku
  domain_name           = var.domain_name
  domain_configuration_type = var.domain_configuration_type
  filtered_sync_enabled = var.filtered_sync_enabled # See https://docs.microsoft.com/en-us/azure/active-directory-domain-services/scoped-synchronization

  initial_replica_set {
    subnet_id = var.subnet_id
  }

  notifications {
    notify_dc_admins = true
  }

  # See https://docs.microsoft.com/en-us/azure/active-directory-domain-services/tutorial-configure-password-hash-sync
  security {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
    kerberos_rc4_encryption_enabled = var.kerberos_rc4_encryption_enabled
  }

  secure_ldap {
    enabled                     = var.ldaps_enable
    external_access_enabled     = var.ldaps_external_access_enabled
    pfx_certificate             = var.ldaps_certificate
    pfx_certificate_password    = var.ldaps_certificate_password
  }

  tags = merge({
    environment          = var.environment_code
    managed_by_terraform = true
  }, var.tags)
}
