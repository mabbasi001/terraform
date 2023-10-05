variable "resource_group_name" {
  description = "The name of the resource group in which this virtual machine should exist."
  type        = string
}

variable "rsv_resource_group_name" {
  description = "The name of the resource group in which this virtual machine should exist."
  type        = string
  default     = null
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created"
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Invalid environment_quality. Allowed values are 'DEV', 'TEST' and 'PROD'."
  }
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')"
  type        = string
  default     = null
}

variable "short_environment_code" {
  description = "A shorter environment code, applied to resources with naming restrictions"
  type        = string
  default     = null
  validation {
    condition     = var.short_environment_code != null ? length(var.short_environment_code) <= 6 : true
    error_message = "Short environment code must contain 4 characters or fewer."
  }
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of both the resource and host"
  type        = string
  default     = null
  validation {
    # This is a maximum of 9 characters because it will be used to generate the host name, which has a maximum of 15 characters. 6 will have been used by the customer and environment codes, leaving 9 available here.
    # The allowed character set is slightly more restrictive than Azure allows. See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.name_suffix == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{1,10})([A-Za-z0-9])$", var.name_suffix)))
    error_message = "Invalid name_suffix. Using this value would result in the generation of an invalid virtual machine host name."
  }
}

variable "name" {
  description = "The name of the virtual machine resource. If provided, this will override the auto-generated name."
  type        = string
  default     = null
}

variable "host_name" {
  description = "The name of the virtual machine host. If provided, this will override the auto-generated host name."
  type        = string
  default     = null
  validation {
    # For some reason, Azure VMs are still limited to valid NetBIOS host names!
    # The allowed character set is slightly more restrictive than Azure allows. See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.host_name == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{1,13})([A-Za-z0-9])$", var.host_name)))
    error_message = "Invalid virtual machine host name."
  }
}

variable "size" {
  description = "Size of the virtual machine. See https://docs.microsoft.com/en-us/azure/virtual-machines/sizes."
  type        = string
  default     = null
}

variable "role" {
  description = "The role of the virtual machine"
  type        = string
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

variable "nics" {
  description = "List of network inteface cards to be create for this virtual machine. Indices in this list must be unique."
  type = list(object({
    index                         = number
    subnet_id                     = string
    private_ip_address_allocation = string
    private_ip_address            = string
  }))
}

variable "os_disk_type" {
  description = "The type of Managed Disk to use for the OS disk"
  type        = string
  default     = null
  validation {
    condition     = (var.os_disk_type == null ? true : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS"], var.os_disk_type))
    error_message = "Invalid os_disk_type. Allowed values are 'Standard_LRS', 'StandardSSD_LRS' and 'Premium_LRS'."
  }
}

variable "os_disk_size_gb" {
  description = "Size of the OS Disk in GB. Must be 128 or greater"
  type        = number
  default     = 128
}

variable "windows_image_publisher" {
  description = "The publisher of the Windows image to be used"
  type        = string
  default     = "MicrosoftWindowsServer"
  validation {
    condition     = contains(["MicrosoftWindowsServer", "MicrosoftWindowsDesktop", "MicrosoftSQLServer","microsoftvisualstudio"], var.windows_image_publisher)
    error_message = "Invalid windows_image_publisher. Allowed values are 'MicrosoftWindowsServer', 'MicrosoftWindowsDesktop', 'MicrosoftSQLServer'."
  }
}

variable "windows_image_offer" {
  description = "The windows offer to be used. This maps to the 'offer' field in ARM."
  type        = string
  default     = "WindowsServer"
  validation {
    condition     = contains(["WindowsServer", "Windows-10", "sql2019-ws2019","visualstudio2019latest"], var.windows_image_offer)
    error_message = "Invalid windows_image_offer. Allowed values are 'WindowsServer', 'Windows-10', 'sql2019-ws2019'."
  }
}

variable "windows_image_sku" {
  description = "The sku of windows image to be used. This maps to the 'sku' field in ARM."
  type        = string
  default     = "2019-Datacenter"
  validation {
    condition     = contains(["2016-Datacenter", "2019-Datacenter", "20h2-pro", "20h2-pro-g2", "Standard","vs-2019-ent-latest-ws2019"], var.windows_image_sku)
    error_message = "Invalid windows_image_sku. Allowed values are '2016-Datacenter', '2019-Datacenter', '20h2-pro', '20h2-pro-g2', 'Standard'."
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

variable "availability_set_id" {
  description = "The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "availability_zone_id" {
  description = "The ID of the Availability Zone in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = number
  default     = null
  validation {
    condition     = var.availability_zone_id == null ? true : (var.availability_zone_id >= 1) && (var.availability_zone_id <= 3)
    error_message = "Invalid Availability Zone ID. Value must be between 1 and 3 (inclusive)."
  }
}

variable "encryption_at_host_enabled" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  type        = bool
  default     = true
}

variable "user_assigned_managed_identity_id" {
  description = "The ID of the user assigned managed identity that this VM should use when authenticating to use Azure resources"
  type        = string
  default     = null
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

variable "iaas_antimalware" {
  description = "Configuration settings of the Microsoft.Azure.Security.IaasAntimalware extension to be installed on the virtual machine."
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

variable "disable_log_analytics" {
  description = "Set to true if no logging to analytics workspace is required"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace to which the Log Analytics extension should write its logs"
  type        = string
  default     = null
}

# Ideally, I would have had a "log_analytics_agent" object containing both of these properties...
# but terraform does not allow marking individual properties of an object as sensitive yet
variable "log_analytics_workspace_key" {
  description = "Access Key of the Log Analytics workspace to which the Log Analytics extension should write its logs"
  type        = string
  sensitive   = true
  default     = null
}

variable "azure_devops_deployment_group_agent" {
  description = "Configuration settings of the Microsoft.VisualStudio.Services.TeamServicesAgent extension to be installed on the virtual machine."
  type = object({
    organisation     = string
    team_project     = string
    deployment_group = string
    tags             = string
  })
  default = null
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

# Ideally, this would have been part of the azure_devops_deployment_group_agent object... but
# terraform does not allow marking individual properties of an object as sensitive yet
variable "azure_devops_deployment_group_agent_pat" {
  description = "The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group."
  type        = string
  default     = null
  sensitive   = true
}

variable "key_vault_agent" {
  description = <<-DESCRIPTION
    Configuration settings of the Microsoft.Azure.KeyVault.KeyVaultForWindows extension to be installed on the virtual machine.

    It is recommended that you do not enable certificate linking when installing this extension on Service Fabric cluster nodes.
    For more details, see: https://docs.microsoft.com/en-us/azure/service-fabric/cluster-security-certificate-management#certificate-linking-explained.
  DESCRIPTION
  type = object({
    observed_certificates = list(object({
      key_vault_name   = string
      key_vault_id     = string
      certificate_name = string
    }))
    link_certificates_on_renewal = bool
  })
  default = {
    observed_certificates        = []
    link_certificates_on_renewal = false
  }
}

variable "dsc_agent" {
  description = "Configuration settings of the Microsoft.Powershell.DSC extension to be installed on the virtual machine."
  type = object({
    automation_account_dsc_endpoint = string
    node_configuration_name         = string
  })
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

# Ideally, this would have been part of the dsc_agent object... but terraform does not allow
# marking individual properties of an object as sensitive yet
variable "automation_account_dsc_access_key" {
  description = "The key to access the DSC endpoint on the automation account."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
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
    condition     = alltrue([for disk in var.data_disks : disk.type == null ? true : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "UltraSSD_LRS"], disk.type)])
    error_message = "Invalid data_disk type. Allowed values are null (for the default), 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS' & 'UltraSSD_LRS'."
  }
  validation {
    condition     = alltrue([for disk in var.data_disks : disk.caching == null ? true : contains(["None", "ReadOnly", "ReadWrite"], disk.caching)])
    error_message = "Invalid data_disk type. Allowed values are null (for the default), 'None', 'ReadOnly', 'ReadWrite' or null."
  }
  validation {
    condition     = length([for disk in var.data_disks : disk.lun]) == length(distinct([for disk in var.data_disks : disk.lun]))
    error_message = "Data Disk LUNs must all be unique."
  }
}

variable "connect_to_avd_pool" {
  description = "Connect VM to the AVD host pool"
  default     = null
}

variable "avd_host_pool_name" {
  description = "Name of the AVD hostpool"
  type        = string
  default     = null
}

variable "avd_host_pool_token" {
  description = "Token from the the AVD hostpool"
  type        = string
  default     = null
}

variable "extensions_creation_delay" {
  description = "Time duration to delay VM extensions creation. See #234962 for more details."
  type        = string
  default     = "30s"
}

variable "domain_join_agent" {
  description = "Configuration settings to domain join Virtual Machines."
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
}

# Ideally, this would have been part of the domain_join_agent object... but terraform doesn't allow
# marking individual properties of an object as sensitive
variable "domain_admin_password" {
  description = "The password of the AD domain admin."
  type        = string
  default     = null
  sensitive   = true
}
