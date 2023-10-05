variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')."
  type        = string
  default     = null
}

variable "targets_secondary_region" {
  description = "Is this targeting the secondary region for DR?"
  type        = bool
  default     = false
}

variable "environment_location_short_code" {
  description = "A short location identifier for environment, a 3 letter version the the region code"
  type        = string
  default     = null
  validation {
    condition     = var.environment_location_short_code != null ? length(var.environment_location_short_code) == 3 : true
    error_message = "Environment Location Short code must contain 3 characters."
  }
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
  description = "The suffix to be appended to the auto-generated name of the resource."
  type        = string
  default     = null
}

variable "environment_quality" {
  description = "The quality of the environment in which the resource is being created."
  type        = string
  validation {
    condition     = contains(["DEV", "TEST", "PROD"], var.environment_quality)
    error_message = "Allowed values for environment_quality are 'DEV', 'TEST', or 'PROD'."
  }
}

variable "name" {
  description = "The name of the Service Fabric cluster."
  type        = string
  default     = null
}

variable "key_vault" {
  description = "Details of the Key Vault containing the cluster/reverse proxy certificates. The password of the virtual machine admin user will also be added to this vault."
  type = object({
    id   = string
    name = string
  })
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace to which all the Log Analytics extensions should write their logs."
  type        = string
}

# Ideally, this would have been part of a "log_analytics_agent" object... but terraform
# does not allow marking individual properties of an object as sensitive
variable "log_analytics_workspace_key" {
  description = "Access Key of the Log Analytics workspace to which all the Log Analytics extensions should write their logs."
  type        = string
  sensitive   = true
}

variable "reliability_level" {
  description = "The reliability level of the Service Fabric Cluster. This dictates the number the 'seed nodes' in the primary node type."
  type        = string
  default     = null
  validation {
    condition     = var.reliability_level == null ? true : contains(["None", "Bronze", "Silver", "Gold", "Platinum"], var.reliability_level)
    error_message = "Allowed values for reliability_level are null (for the default), 'None', 'Bronze', 'Silver', 'Gold' or 'Platinum'."
  }
}

variable "cluster_management_uri" {
  description = "The URI of the Service Fabric cluster. Used to construct the full management endpoint URLs."
  type        = string
}

variable "upgrade_mode" {
  description = "Upgrade mode of the cluster."
  type        = string
  default     = "Manual"
  validation {
    condition     = contains(["Automatic", "Manual"], var.upgrade_mode)
    error_message = "Allowed values for upgrade_mode are 'Automatic' and 'Manual'."
  }
}

variable "cluster_version" {
  description = "Specifies the Version of the Cluster Code of the cluster. Required if Upgrade Mode set to Manual. Ignored otherwise."
  type        = string
  default     = null
}

variable "cluster_os_type" {
  description = "The type of OS that the VMSSs have been configured with. Generic names such as Windows or Linux can be used."
  type        = string
  default     = "Windows"
}

variable "cluster_certificates" {
  description = <<-DESCRIPTION
    Details of the required Service Fabric cluster certificates.

    Note: If more than one cluster or reverse proxy certificate is specified, the cluster will use whichever one has latest start date (not the latest expiry date!).
  DESCRIPTION
  type = map(object({
    type              = string
    pfx_path          = string
    common_name       = string
    issuer_thumbprint = string
    key_type          = string
    key_size          = number
  }))
  validation {
    condition     = alltrue([for cert in var.cluster_certificates : contains(["cluster", "reverse_proxy", "secrets"], cert.type)])
    error_message = "All Service Fabric Cluster Certificate must be of type 'cluster', 'reverse_proxy' or 'secrets'."
  }
  validation {
    condition     = length([for cert in var.cluster_certificates : cert if cert.type == "cluster"]) > 0
    error_message = "At least one Service Fabric Cluster Certificate of type 'cluster' must be provided."
  }
  validation {
    condition     = length([for cert in var.cluster_certificates : cert if cert.type == "reverse_proxy"]) > 0
    error_message = "At least one Service Fabric Cluster Certificate of type 'reverse_proxy' must be provided."
  }
}

# Ideally, this would have been part of the "cluster_certificates" map... but terraform
# doesn't allow marking individual properties of an object as sensitive
variable "cluster_certificate_pfx_passwords" {
  description = <<-DESCRIPTION
    Password of the pfx file containing the Service Fabric cluster certificates.
    Note: The keys must match those defined in the cluster_certificates map.
  DESCRIPTION
  type        = map(string)
  sensitive   = true
}

variable "service_fabric_cluster_app_reg_display_name" {
  description = "An override for the auto-generated display name of the App Registration representing the Service Fabric Cluster"
  type        = string
  default     = null
}

variable "service_fabric_client_app_reg_display_name" {
  description = "An override for the auto-generated display name of the App Registration representing a client application that is calling the Service Fabric Cluster"
  type        = string
  default     = null
}

variable "authentication_tenant_id" {
  description = "ID of the tenant that will be authenticating access to the service fabric cluster"
  type        = string
}

variable "client_certificates" {
  description = "Details of the required Service Fabric client certificates."
  type = map(object({
    common_name       = string
    issuer_thumbprint = string
    is_admin          = bool
  }))
  default = {}
}

variable "tcp_administration_endpoint_port" {
  description = "Port to use when connecting to the cluster using a TCP connection (e.g. when using the Service Fabric PowerShell module)."
  type        = number
  default     = 19000
}

variable "http_administration_endpoint_port" {
  description = "Port to use when connecting to the Cluster Explorer web UI"
  type        = number
  default     = 19080
}

variable "reverse_proxy_endpoint_port" {
  description = "The port on which the reverse proxy service will expose itself from the cluster"
  type        = number
  default     = 19081
}

variable "internal_load_balancer" {
  description = "Details of the internal load balancer to be created for this Service Fabric cluster"
  type = object({
    subnet_id                        = string
    tcp_administration_gateway_port  = number
    http_administration_gateway_port = number
    reverse_proxy_gateway_port       = number
    private_ip_address               = string
    sku_name                         = string
  })
  validation {
    condition     = var.internal_load_balancer.subnet_id != null
    error_message = "The resource ID of the subnet to which the internal_load_balancer will be attached is mandatory."
  }
}

variable "windows_ad_domain" {
  description = "Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances."
  type = object({
    domain                = string
    domain_admin_username = string
    ou_path               = string
  })
  default = null
  validation {
    condition     = var.windows_ad_domain == null ? true : var.windows_ad_domain.domain != null
    error_message = "The name of the domain to which the VMSS instances should be joined is mandatory."
  }
  validation {
    condition     = var.windows_ad_domain == null ? true : var.windows_ad_domain.domain_admin_username != null
    error_message = "The username of a user with rights to join machines to the domain is mandatory."
  }
}

# Ideally, this would have been part of the windows_ad_domain object... but terraform doesn't allow
# marking individual properties of an object as sensitive
variable "domain_admin_password" {
  description = "The username of the AD domain admin."
  type        = string
  default     = null
  sensitive   = true
}

# variable "automation_account_dsc_endpoint" {
#   description = "The DSC endpoint of the automation account containing the Node Configuration to be used by the service fabric virtual machine scale sets."
#   type        = string
# }

# variable "automation_account_dsc_access_key" {
#   description = "An access key allowing access to the DSC endpoint of the automation account."
#   type        = string
#   sensitive   = true
# }

variable "node_types" {
  description = "Details of the node types needed in the Service Fabric Cluster"
  type = map(object({
    subnet = object({
      id               = string
      name             = string
      address_prefixes = list(string)
    })
    instance_count       = number
    instance_size        = string
    is_primary           = bool
    timezone             = string
    placement_properties = map(string)
    capacity_tags        = map(string)
    durability_level     = string
    os_disk = object({
      type    = string
      size_gb = number
    })
    application_ports = object({
      start_port = number
      end_port   = number
    })
    ephemeral_ports = object({
      start_port = number
      end_port   = number
    })
    enable_accelerated_networking = bool
  }))
  validation {
    condition     = alltrue([for nt in var.node_types : nt.subnet != null])
    error_message = "All node types must have a subnet specified."
  }
  validation {
    condition     = sum([for nt in var.node_types : nt.is_primary ? 1 : 0]) == 1
    error_message = "One (and only one) node type must be marked as primary."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : coalesce(nt.instance_count, 1) > 0])
    error_message = "All node types must have an instance_count that is greater than zero."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : nt.timezone == null ? true : contains(["UTC", "GMT Standard Time", "Cen. Australia Standard Time"], nt.timezone)])
    error_message = "The timezone of all node types must be one of the following: null (for the default), 'UTC', 'GMT Standard Time' or 'Cen. Australia Standard Time'."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : contains(["Bronze", "Silver", "Gold"], coalesce(nt.durability_level, "Bronze"))])
    error_message = "The durability_level of all node types must be one of 'Bronze', 'Silver' or 'Gold'."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : nt.os_disk == null ? true : (nt.os_disk.type == null ? true : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS"], nt.os_disk.type) && (nt.os_disk.size_gb == null ? true : nt.os_disk.size_gb >= 128))])
    error_message = "If os_disk is supplied for any node type, it must be 128GB or larger and it must be of one of the following types: null (for the default), 'Standard_LRS', 'StandardSSD_LRS' & 'Premium_LRS'."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : nt.application_ports == null ? true : nt.application_ports.start_port < nt.application_ports.end_port])
    error_message = "All nodes types must have application start_ports that are less than their corresponding end_ports."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : nt.ephemeral_ports == null ? true : nt.ephemeral_ports.start_port < nt.ephemeral_ports.end_port])
    error_message = "All nodes types must have ephemeral start_ports that are less than their corresponding end_ports."
  }
  validation {
    condition     = alltrue([for nt in var.node_types : (nt.application_ports == null) || (nt.ephemeral_ports == null) ? true : (nt.application_ports.end_port < nt.ephemeral_ports.start_port) || (nt.application_ports.start_port > nt.ephemeral_ports.end_port)])
    error_message = "All node types must have non-overlapping application and ephemeral port ranges."
  }
}

variable "tags" {
  description = "A map of tags that should be assigned to the resources."
  type        = map(string)
  default     = {}
}

variable "vmss_local_admin_password" {
  description = "The password associated with VMSS local administrator account."
  type        = string
  sensitive   = true
}

variable "user_assigned_managed_identity_name" {
  description = "The name of a user assigned managed identity that this VM should use when authenticating to Azure resources"
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

variable "cluster_certificate_notification_days_before_expiry" {
  description = "Number of days before the certificates' expiry dates when a notification will be generated."
  type        = number
  default     = 90
}

variable "disable_iaas_extension" {
  description = "Optionally disable Iaas Anti-Malware Extension, allows for deferred addition of the extension within Enterprise Dev/Test offers."
  type        = bool
  default     = false
}

variable "azure_devops_pool_agent_pat" {
  description = "The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group."
  type        = string
  default     = null
  sensitive   = true
}

variable "azure_devops_organization" {
  description = "Target Azure DevOps Organization for Virtual Machine State Configuration."
  type        = string
}

variable "azure_devops_product_organization" {
  description = "Target Azure DevOps Organization for Product Deployments."
  type        = string
  default     = null
}

variable "azure_devops_project" {
  description = "Target Azure DevOps Project for Virtual Machine State Configuration."
  type        = string
}

variable "azure_devops_product_project" {
  description = "Target Azure DevOps Project for Product Deployments."
  type        = string
  default     = null
}

variable "devops_agent_script_url" {
  description = "Download URL for the DevOps Agent Pool Script."
  type        = string
  sensitive   = true
}

variable "azure_devops_agent_pool_name" {
  description = "Azure DevOps Agent pool for Virtual Machine State Configuration."
  type        = string
  default     = null
}

variable "azure_devops_product_agent_pool_name" {
  description = "Azure DevOps Agent pool for Product Deployments."
  type        = string
  default     = null
}

variable "state_configuration_storage_account_id" {
  description = "The storage account id within which state configuration assets reside."
  type = string
  default = null
}

variable "enable_state_configuration_access" {
  description = "Create RBAC access to state configuration storage account."
  type = bool
  default = false
}

variable "deploy_sf_azure_ad_app" {
  description = "Deploy Azure AD app regs?"
  type = bool
  default = true
}

variable "enable_threat_protection" {
  description = "Enable threat protection on storage account resource"
  type        = bool
  default     = true
}
