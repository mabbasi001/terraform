<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cpce_vm_nics"></a> [cpce\_vm\_nics](#module\_cpce\_vm\_nics) | ../cpce_network_interface | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_managed_disk.managed_data_disks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_role_assignment.vm_key_vault_role_assigment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vm_storage_account_state_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.azure_devops_deployment_group_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.azure_devops_pool_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.azure_policy_for_windows_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.connect_to_avd_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.dependency_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.iaas_antimalware_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.key_vault_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.log_analytics_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.vm_domain_join_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [time_sleep.extensions_creation_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_dsc_access_key"></a> [automation\_account\_dsc\_access\_key](#input\_automation\_account\_dsc\_access\_key) | The key to access the DSC endpoint on the automation account. | `string` | `null` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_availability_zone_id"></a> [availability\_zone\_id](#input\_availability\_zone\_id) | The ID of the Availability Zone in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_avd_host_pool_name"></a> [avd\_host\_pool\_name](#input\_avd\_host\_pool\_name) | Name of the AVD hostpool | `string` | `null` | no |
| <a name="input_avd_host_pool_token"></a> [avd\_host\_pool\_token](#input\_avd\_host\_pool\_token) | Token from the the AVD hostpool | `string` | `null` | no |
| <a name="input_azure_devops_deployment_group_agent"></a> [azure\_devops\_deployment\_group\_agent](#input\_azure\_devops\_deployment\_group\_agent) | Configuration settings of the Microsoft.VisualStudio.Services.TeamServicesAgent extension to be installed on the virtual machine. | <pre>object({<br>    organisation     = string<br>    team_project     = string<br>    deployment_group = string<br>    tags             = string<br>  })</pre> | `null` | no |
| <a name="input_azure_devops_deployment_group_agent_pat"></a> [azure\_devops\_deployment\_group\_agent\_pat](#input\_azure\_devops\_deployment\_group\_agent\_pat) | The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group. | `string` | `null` | no |
| <a name="input_azure_devops_pool_agent"></a> [azure\_devops\_pool\_agent](#input\_azure\_devops\_pool\_agent) | Configuration settings of the custom script extension for a DevOps Agent to be installed on the virtual machine. | <pre>object({<br>    organisation     = string<br>    team_project     = string<br>    environment_name = string<br>    agent_pool       = string<br>    agent_workload   = string<br>    agent_script_url = string<br>  })</pre> | `null` | no |
| <a name="input_azure_devops_product_pool_agent"></a> [azure\_devops\_product\_pool\_agent](#input\_azure\_devops\_product\_pool\_agent) | Configuration settings of the custom script extension for a DevOps Agent in the organisation the code is hosted to be installed on the virtual machine. | <pre>object({<br>    organisation     = string<br>    team_project     = string<br>    environment_name = string<br>    agent_pool       = string<br>    agent_workload   = string<br>    agent_script_url = string<br>  })</pre> | `null` | no |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | Specifies the id of the backup policy to use. | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot\_diagnostics\_storage\_account\_uri](#input\_boot\_diagnostics\_storage\_account\_uri) | The Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics. Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics. | `string` | `null` | no |
| <a name="input_connect_to_avd_pool"></a> [connect\_to\_avd\_pool](#input\_connect\_to\_avd\_pool) | Connect VM to the AVD host pool | `any` | `null` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | List of data disks to be created for each VMSS instance. | <pre>map(object({<br>    size_gb = number<br>    type    = string<br>    lun     = number<br>    caching = string<br>  }))</pre> | `{}` | no |
| <a name="input_disable_log_analytics"></a> [disable\_log\_analytics](#input\_disable\_log\_analytics) | Set to true if no logging to analytics workspace is required | `bool` | `false` | no |
| <a name="input_domain_admin_password"></a> [domain\_admin\_password](#input\_domain\_admin\_password) | The password of the AD domain admin. | `string` | `null` | no |
| <a name="input_domain_join_agent"></a> [domain\_join\_agent](#input\_domain\_join\_agent) | Configuration settings to domain join Virtual Machines. | <pre>object({<br>    domain                = string<br>    domain_admin_username = string<br>    ou_path               = string<br>  })</pre> | `null` | no |
| <a name="input_dsc_agent"></a> [dsc\_agent](#input\_dsc\_agent) | Configuration settings of the Microsoft.Powershell.DSC extension to be installed on the virtual machine. | <pre>object({<br>    automation_account_dsc_endpoint = string<br>    node_configuration_name         = string<br>  })</pre> | `null` | no |
| <a name="input_enable_state_configuration_access"></a> [enable\_state\_configuration\_access](#input\_enable\_state\_configuration\_access) | Create RBAC access to state configuration storage account. | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `true` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_extensions_creation_delay"></a> [extensions\_creation\_delay](#input\_extensions\_creation\_delay) | Time duration to delay VM extensions creation. See #234962 for more details. | `string` | `"30s"` | no |
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | The name of the virtual machine host. If provided, this will override the auto-generated host name. | `string` | `null` | no |
| <a name="input_iaas_antimalware"></a> [iaas\_antimalware](#input\_iaas\_antimalware) | Configuration settings of the Microsoft.Azure.Security.IaasAntimalware extension to be installed on the virtual machine. | <pre>object({<br>    exclusions = object({<br>      extensions = list(string)<br>      paths      = list(string)<br>      processes  = list(string)<br>    }),<br>    scheduled_scan = object({<br>      enabled = bool<br>    })<br>  })</pre> | <pre>{<br>  "exclusions": {<br>    "extensions": [],<br>    "paths": [],<br>    "processes": []<br>  },<br>  "scheduled_scan": {<br>    "enabled": true<br>  }<br>}</pre> | no |
| <a name="input_key_vault_agent"></a> [key\_vault\_agent](#input\_key\_vault\_agent) | Configuration settings of the Microsoft.Azure.KeyVault.KeyVaultForWindows extension to be installed on the virtual machine.<br><br>It is recommended that you do not enable certificate linking when installing this extension on Service Fabric cluster nodes.<br>For more details, see: https://docs.microsoft.com/en-us/azure/service-fabric/cluster-security-certificate-management#certificate-linking-explained. | <pre>object({<br>    observed_certificates = list(object({<br>      key_vault_name   = string<br>      key_vault_id     = string<br>      certificate_name = string<br>    }))<br>    link_certificates_on_renewal = bool<br>  })</pre> | <pre>{<br>  "link_certificates_on_renewal": false,<br>  "observed_certificates": []<br>}</pre> | no |
| <a name="input_local_admin_password"></a> [local\_admin\_password](#input\_local\_admin\_password) | The password associated with the local administrator account. | `string` | n/a | yes |
| <a name="input_local_admin_username"></a> [local\_admin\_username](#input\_local\_admin\_username) | Username of the local admin user account. | `string` | `"vmadmin"` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID of the Log Analytics Workspace to which the Log Analytics extension should write its logs | `string` | `null` | no |
| <a name="input_log_analytics_workspace_key"></a> [log\_analytics\_workspace\_key](#input\_log\_analytics\_workspace\_key) | Access Key of the Log Analytics workspace to which the Log Analytics extension should write its logs | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual machine resource. If provided, this will override the auto-generated name. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of both the resource and host | `string` | `null` | no |
| <a name="input_nics"></a> [nics](#input\_nics) | List of network inteface cards to be create for this virtual machine. Indices in this list must be unique. | <pre>list(object({<br>    index                         = number<br>    subnet_id                     = string<br>    private_ip_address_allocation = string<br>    private_ip_address            = string<br>  }))</pre> | n/a | yes |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Size of the OS Disk in GB. Must be 128 or greater | `number` | `128` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of Managed Disk to use for the OS disk | `string` | `null` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | Specifies the name of the Recovery Services Vault to use. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this virtual machine should exist. | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The role of the virtual machine | `string` | n/a | yes |
| <a name="input_rsv_resource_group_name"></a> [rsv\_resource\_group\_name](#input\_rsv\_resource\_group\_name) | The name of the resource group in which this virtual machine should exist. | `string` | `null` | no |
| <a name="input_short_environment_code"></a> [short\_environment\_code](#input\_short\_environment\_code) | A shorter environment code, applied to resources with naming restrictions | `string` | `null` | no |
| <a name="input_size"></a> [size](#input\_size) | Size of the virtual machine. See https://docs.microsoft.com/en-us/azure/virtual-machines/sizes. | `string` | `null` | no |
| <a name="input_state_configuration_storage_account_id"></a> [state\_configuration\_storage\_account\_id](#input\_state\_configuration\_storage\_account\_id) | The storage account id within which state configuration assets reside. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The time zone which should be used by the virtual machine | `string` | `"UTC"` | no |
| <a name="input_user_assigned_managed_identity_id"></a> [user\_assigned\_managed\_identity\_id](#input\_user\_assigned\_managed\_identity\_id) | The ID of the user assigned managed identity that this VM should use when authenticating to use Azure resources | `string` | `null` | no |
| <a name="input_windows_image_offer"></a> [windows\_image\_offer](#input\_windows\_image\_offer) | The windows offer to be used. This maps to the 'offer' field in ARM. | `string` | `"WindowsServer"` | no |
| <a name="input_windows_image_publisher"></a> [windows\_image\_publisher](#input\_windows\_image\_publisher) | The publisher of the Windows image to be used | `string` | `"MicrosoftWindowsServer"` | no |
| <a name="input_windows_image_sku"></a> [windows\_image\_sku](#input\_windows\_image\_sku) | The sku of windows image to be used. This maps to the 'sku' field in ARM. | `string` | `"2019-Datacenter"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_computer_name"></a> [computer\_name](#output\_computer\_name) | The host name of the virtual machine. |
| <a name="output_id"></a> [id](#output\_id) | The resource ID of the virtual machine. |
| <a name="output_name"></a> [name](#output\_name) | The name of the virtual machine. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The identity information appropriate to this resource. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Private IP address assigned to the virual machine's NIC. |
<!-- END_TF_DOCS -->