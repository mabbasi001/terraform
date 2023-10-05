variable "role" {
  description = "The role of the virtual machine scale set"
  type        = string
  validation {
    condition = contains(
      [
        "azure_pipelines_agent",
        "service_fabric_cluster"
    ], var.role)
    error_message = "Invalid role. Allowed values are 'azure_pipelines_agent' & 'service_fabric_cluster'."
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which the Windows Virtual Machine Scale Set should be exist."
  type        = string
}

variable "location" {
  description = "The Azure location where the Windows Virtual Machine Scale Set should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = ""
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')"
  type        = string
  default     = null
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Invalid environment_quality. Allowed values are 'DEV', 'TEST' and 'PROD'."
  }
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of VMSS resource"
  type        = string
  default     = null
  validation {
    # the VMSS resource name has a maximum length of 64 characters. 12 will have been used by the resource
    # abbreviation customer and environment codes and their separators (e.g. vmss-sbl-uat). Another one
    # will be used for the suffix separator ('-' if needed) leaving 51 more available for the suffix
    condition     = (var.name_suffix == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{0,49})([A-Za-z0-9]){0,1}$", var.name_suffix)))
    error_message = "Invalid name_suffix. Using this value would result in the generation of a VMSS resource name that exceeds 64 characters."
  }
}

variable "host_name_suffix" {
  description = "The suffix to be appended to the auto-generated host names of the VMSS instances"
  type        = string
  default     = null
  validation {
    # The host name of the VMSS instances is limited to 15 characters, but scale sets reserve six for instance numbers.
    # Six more will have been used by the customer and environment codes, leaving just three available for this suffix.
    # See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.host_name_suffix == null ? true : can(regex("^([a-zA-Z0-9]){1,3}$", var.host_name_suffix)))
    error_message = "Invalid host_name_suffix. Using this value would result in the generation of an VMSS instance host name that exceeds 15 characters."
  }
}

variable "name" {
  description = "The name which should be used for this resource. If supplied, it will override the auto-generated name."
  type        = string
  default     = null
  validation {
    condition     = (var.name == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{0,62})([A-Za-z0-9]){0,1}$", var.name)))
    error_message = "Invalid name. The name of VMSS resources is limited to 64 characters."
  }
}

variable "host_name" {
  description = "The host name of the VMSS instances. If provided, this will override the auto-generated host name."
  type        = string
  default     = null
  validation {
    condition     = (var.host_name == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{0,7})([A-Za-z0-9]){0,1}$", var.host_name)))
    error_message = "Invalid host name. The host name of VMSS instances is limited to 15 characters, of which six are used by the VMSS instance IDs."
  }
}

variable "instance_size" {
  description = "The size of the VMSS instances (e.g. Standard_F2)."
  type        = string
  default     = null
}

variable "instance_count" {
  description = "The number of instances to provision in the VMSS."
  type        = number
  default     = null
}

variable "os_disk" {
  description = "Details of the OS Disk to be provisioned for each VMSS instance"
  type = object({
    type      = string
    size_gb   = number
    ephemeral = bool
  })
  default = {
    type      = null
    size_gb   = null
    ephemeral = false
  }
  validation {
    condition     = var.os_disk.type == null ? true : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS"], var.os_disk.type)
    error_message = "Invalid os_disk.type. Allowed values are null (for the default), 'Standard_LRS', 'StandardSSD_LRS' & 'Premium_LRS'."
  }
}

variable "data_disks" {
  description = "List of data disks to be created for each VMSS instance."
  type = map(object({
    size_gb = number
    type    = string
    lun     = number
    caching = string
  }))
  default = {}
  validation {
    condition     = alltrue([for disk in var.data_disks : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "UltraSSD_LRS"], disk.type)])
    error_message = "Invalid data_disk type. Allowed values are null (for the default), 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS' & 'UltraSSD_LRS'."
  }
  validation {
    condition     = alltrue([for disk in var.data_disks : contains(["None", "ReadOnly", "ReadWrite"], disk.caching)])
    error_message = "Invalid data_disk type. Allowed values are null (for the default), 'None', 'ReadOnly', 'ReadWrite' or null."
  }
  validation {
    condition     = length([for disk in var.data_disks : disk.lun]) == length(distinct([for disk in var.data_disks : disk.lun]))
    error_message = "Data Disk LUNs must all be unique."
  }
}

variable "nic" {
  description = "List of network interface cards to be created for each VMSS instance."
  type = object({
    subnet_id                                    = string
    application_gateway_backend_address_pool_ids = list(string)
    load_balancer_backend_address_pool_ids       = list(string)
    enable_accelerated_networking                = bool
  })
  validation {
    condition     = !((var.nic.application_gateway_backend_address_pool_ids != null) && (var.nic.load_balancer_backend_address_pool_ids != null))
    error_message = "Invalid NIC specification. Please provide the backend address pool id of an application gateway, a load balancer, or neither (in this case a private IP will be dynamically chosen from the subnet for each VMSS instance)."
  }
}

variable "user_assigned_managed_identity_name" {
  description = "The name of a user assigned managed identity that this VM should use when authenticating to Azure resources"
  type        = string
  default     = null
}

variable "user_assigned_managed_identity_objectid" {
  description = "The ObjectID of a user assigned managed identity that this VM should use when authenticating to Azure resources"
  type        = string
  default     = null
}

variable "zones" {
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created. Changing this forces a new resource to be created."
  type        = list(number)
}

variable "windows_image_publisher" {
  description = "The publisher of the Windows image to be used"
  type        = string
  default     = "MicrosoftWindowsServer"
  validation {
    condition     = contains(["MicrosoftWindowsServer", "MicrosoftWindowsDesktop"], var.windows_image_publisher)
    error_message = "Invalid windows_image_publisher. Allowed values are 'MicrosoftWindowsServer' or 'MicrosoftWindowsDesktop'."
  }
}

variable "windows_image_offer" {
  description = "The windows offer to be used. This maps to the 'offer' field in ARM."
  type        = string
  default     = "WindowsServer"
  validation {
    condition     = contains(["WindowsServer", "Windows-10"], var.windows_image_offer)
    error_message = "Invalid windows_image_offer. Allowed values are 'WindowsServer', 'Windows-10'."
  }
}

variable "windows_image_sku" {
  description = "The sku of windows image to be used. This maps to the 'sku' field in ARM."
  type        = string
  default     = "2019-Datacenter"
  validation {
    condition     = contains(["2016-Datacenter", "2019-Datacenter", "20h2-pro", "20h2-pro-g2"], var.windows_image_sku)
    error_message = "Invalid windows_image_sku. Allowed values are '2016-Datacenter', '2019-Datacenter', '20h2-pro' or '20h2-pro-g2'."
  }
}

variable "timezone" {
  description = "The time zone which should be used by the virtual machine"
  type        = string
  default     = "UTC"
  validation {
    condition     = contains(["UTC", "GMT Standard Time", "Cen. Australia Standard Time"], var.timezone)
    error_message = "Invalid timezone. Allowed values are 'UTC', 'GMT Standard Time' or 'Cen. Australia Standard Time'."
  }
}

variable "local_admin_username" {
  description = "Username of the local admin user account."
  type        = string
  default     = "vmadmin"
}

variable "local_admin_password" {
  description = "The password associated with the local administrator account."
  type        = string
  sensitive   = true
}

variable "local_admin_password_key_vault_id" {
  description = "Resource ID of the Key Vault in which to store the password of the local admin account."
  type        = string
}

variable "upgrade_mode" {
  description = "When changes are made to the scale set model, how should those changes be rolled out to all instances?"
  type        = string
  default     = "Manual"
  validation {
    condition     = contains(["Manual", "Automatic"], var.upgrade_mode)
    error_message = "Invalid upgrade_mode. Allowed values are 'Manual' or 'Automatic''."
  }
}

variable "encryption_at_host_enabled" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  type        = bool
  default     = true
}

variable "boot_diagnostics_storage_account_uri" {
  description = "The Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics. Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics."
  type        = string
  default     = null
}

variable "recovery_vault_name" {
  description = "Specifies the name of the Recovery Services Vault to use."
  type        = string
  default     = null
}

variable "backup_policy_id" {
  description = "Specifies the id of the backup policy to use."
  type        = string
  default     = null
}

variable "iaas_antimalware_agent" {
  description = "Configuration settings of the Microsoft.Azure.Security.IaasAntimalware extension to be installed on the VMSS instances."
  type = object({
    exclusions = object({
      extensions = list(string)
      paths      = list(string)
      processes  = list(string)
    }),
    scheduled_scan = object({
      enabled = bool
    })
  })
  default = {
    exclusions = {
      extensions = []
      paths      = []
      processes  = []
    },
    scheduled_scan = {
      enabled = true
    }
  }
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace to which the Log Analytics extension should write its logs"
  type        = string
}

# Ideally, this would have been part of a log_analytics_agent object... but terraform
# does not allow marking individual properties of an object as sensitive
variable "log_analytics_workspace_key" {
  description = "Access Key of the Log Analytics workspace to which the Log Analytics extension should write its logs"
  type        = string
  sensitive   = true
}

# Unfortunately, I'm having to move the key_vault_id and key_vault_name out of the observed_certificates array.
# This is because the for_each loop in the main.tf can't rely on a map containing a value that is only known
# at apply time (the key_vault_id in this instance). However this means that a VMSS can now only observe
# certificates in one key vault. This isn't a problem for us right now though, so I won't try to solve it.
variable "key_vault_agent" {
  description = <<-DESCRIPTION
    Configuration settings of the Microsoft.Azure.KeyVault.KeyVaultForWindows extension to be installed on the VMSS instances.

    It is recommended that you do not enable certificate linking when installing this extension on Service Fabric cluster nodes.
    For more details, see: https://docs.microsoft.com/en-us/azure/service-fabric/cluster-security-certificate-management#certificate-linking-explained.
  DESCRIPTION
  type = object({
    key_vault_id                 = string
    key_vault_name               = string
    observed_certificate_names   = list(string)
    link_certificates_on_renewal = bool
  })
  default = null
}

variable "custom_script_extension" {
  description = "Configuration settings of the Microsoft.Compute.CustomScriptExtension extension to be installed on the VMSS instances."
  type = object({
    script_to_run = string
  })
  default = null
}

variable "domain_join_agent" {
  description = "Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances."
  type = object({
    domain                = string
    domain_admin_username = string
    ou_path               = string
  })
  default = null
  validation {
    condition     = var.domain_join_agent == null ? true : var.domain_join_agent.domain != null
    error_message = "The domain of the Domain Join Agent is mandatory."
  }
  validation {
    condition     = var.domain_join_agent == null ? true : var.domain_join_agent.domain_admin_username != null
    error_message = "The domain_admin_username of the Domain Join Agent is mandatory."
  }
  validation {
    condition     = var.domain_join_agent == null ? true : var.domain_join_agent.ou_path != null
    error_message = "The ou_path of the Domain Join Agent is mandatory."
  }
}

# Ideally, this would have been part of the domain_join_agent object... but terraform doesn't allow
# marking individual properties of an object as sensitive
variable "domain_admin_password" {
  description = "The username of the AD domain admin."
  type        = string
  default     = null
  sensitive   = true
}

# variable "dsc_agent" {
#   description = "Configuration settings of the Microsoft.Powershell.DSC extension to be installed on the virtual machine."
#   type = object({
#     automation_account_dsc_endpoint = string
#     node_configuration_name         = string
#   })
#   default = null
# }

variable "azure_devops_pool_agent_pat" {
  description = "The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group."
  type        = string
  default     = null
  sensitive   = true
}

# Agent Configuration for Agent Pool DevOps Agent
variable "azure_devops_pool_agent" {
  description = "Configuration settings of the custom script extension for a DevOps Agent to be installed on the virtual machine."
  sensitive   = true
  type = object({
    organisation     = string
    team_project     = string
    environment_name = string
    agent_pool       = string
    agent_workload   = string
    agent_script_url = string
  })
  default = null
}

# Agent Configuration for Product Agent Pool DevOps Agent
variable "azure_devops_product_pool_agent" {
  description = "Configuration settings of the custom script extension for a DevOps Agent in the organisation the code is hosted to be installed on the virtual machine."
  sensitive   = true
  type = object({
    organisation     = string
    team_project     = string
    environment_name = string
    agent_pool       = string
    agent_workload   = string
    agent_script_url = string
  })
  default = null
}

# Ideally, this would have been part of the dsc_agent object... but terraform does not allow
# marking individual properties of an object as sensitive yet
variable "automation_account_dsc_access_key" {
  description = "The key to access the DSC endpoint on the automation account."
  type        = string
  default     = null
  sensitive   = true
}

variable "service_fabric_agent" {
  description = "Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances."
  type = object({
    cluster_endpoint                       = string
    node_type                              = string
    fabric_root_path                       = string
    durability_level                       = string
    nic_prefix_override                    = string
    cluster_certificate_common_names       = list(string)
    reverse_proxy_certificate_common_names = list(string)
  })
  default = null
  validation {
    condition     = var.service_fabric_agent == null ? true : var.service_fabric_agent.cluster_endpoint != null
    error_message = "The cluster_endpoint of the Service Fabric Agent is mandatory."
  }
  validation {
    condition     = var.service_fabric_agent == null ? true : var.service_fabric_agent.node_type != null
    error_message = "The node_type of the Service Fabric Agent is mandatory."
  }
  validation {
    condition     = var.service_fabric_agent == null ? true : var.service_fabric_agent.fabric_root_path != null
    error_message = "The fabric_root_path of the Service Fabric Agent is mandatory."
  }
  validation {
    condition     = var.service_fabric_agent == null ? true : var.service_fabric_agent.durability_level != null
    error_message = "The durability_level of the Service Fabric Agent is mandatory."
  }
  validation {
    condition     = var.service_fabric_agent == null ? true : (var.service_fabric_agent.cluster_certificate_common_names != null) && (length(var.service_fabric_agent.cluster_certificate_common_names) > 0)
    error_message = "The cluster_certificate_common_names of the Service Fabric Agent is mandatory."
  }
}

# Ideally, this would have been part of the service_fabric_agent object... but terraform doesn't allow
# marking individual properties of an object as sensitive
variable "service_fabric_agent_log_storage_account_keys" {
  description = "Access keys for the log storage account to be used by the Service Fabric Agent extension."
  type = object({
    primary_access_key   = string
    secondary_access_key = string
  })
  sensitive = true
  default   = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resources."
  type        = map(string)
  default     = {}
}

variable "disable_iaas_extension" {
  description = "Optionally disable Iaas Anti-malware Extension, allows for deferred addition of the extension within Enterprise Dev/Test offers."
  type        = bool
  default     = false
}

variable "cluster_certificates" {
  description = "List from Service Fabric Key Vault with certificate information"
  type = map(object({
    name = string
  }))
  default = null
}

variable "enable_state_configuration_access" {
  description = "Create RBAC access to state configuration storage account."
  type = bool
  default = false
}

variable "state_configuration_storage_account_id" {
  description = "The storage account id within which state configuration assets reside."
  type = string
  default = null
}
