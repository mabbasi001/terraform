<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.local_admin_password_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_role_assignment.user_assigned_managed_identity_key_vault_secrets_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vm_storage_account_state_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.scale_set_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine_scale_set_extension.IaaSAntimalwareAgent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |
| [azurerm_windows_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine_scale_set) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_user_assigned_identity.user_assigned_managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_dsc_access_key"></a> [automation\_account\_dsc\_access\_key](#input\_automation\_account\_dsc\_access\_key) | The key to access the DSC endpoint on the automation account. | `string` | `null` | no |
| <a name="input_azure_devops_pool_agent"></a> [azure\_devops\_pool\_agent](#input\_azure\_devops\_pool\_agent) | Configuration settings of the custom script extension for a DevOps Agent to be installed on the virtual machine. | <pre>object({<br>    organisation     = string<br>    team_project     = string<br>    environment_name = string<br>    agent_pool       = string<br>    agent_workload   = string<br>    agent_script_url = string<br>  })</pre> | `null` | no |
| <a name="input_azure_devops_pool_agent_pat"></a> [azure\_devops\_pool\_agent\_pat](#input\_azure\_devops\_pool\_agent\_pat) | The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group. | `string` | `null` | no |
| <a name="input_azure_devops_product_pool_agent"></a> [azure\_devops\_product\_pool\_agent](#input\_azure\_devops\_product\_pool\_agent) | Configuration settings of the custom script extension for a DevOps Agent in the organisation the code is hosted to be installed on the virtual machine. | <pre>object({<br>    organisation     = string<br>    team_project     = string<br>    environment_name = string<br>    agent_pool       = string<br>    agent_workload   = string<br>    agent_script_url = string<br>  })</pre> | `null` | no |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | Specifies the id of the backup policy to use. | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot\_diagnostics\_storage\_account\_uri](#input\_boot\_diagnostics\_storage\_account\_uri) | The Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics. Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics. | `string` | `null` | no |
| <a name="input_cluster_certificates"></a> [cluster\_certificates](#input\_cluster\_certificates) | List from Service Fabric Key Vault with certificate information | <pre>map(object({<br>    name = string<br>  }))</pre> | `null` | no |
| <a name="input_custom_script_extension"></a> [custom\_script\_extension](#input\_custom\_script\_extension) | Configuration settings of the Microsoft.Compute.CustomScriptExtension extension to be installed on the VMSS instances. | <pre>object({<br>    script_to_run = string<br>  })</pre> | `null` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `""` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | List of data disks to be created for each VMSS instance. | <pre>map(object({<br>    size_gb = number<br>    type    = string<br>    lun     = number<br>    caching = string<br>  }))</pre> | `{}` | no |
| <a name="input_disable_iaas_extension"></a> [disable\_iaas\_extension](#input\_disable\_iaas\_extension) | Optionally disable Iaas Anti-malware Extension, allows for deferred addition of the extension within Enterprise Dev/Test offers. | `bool` | `false` | no |
| <a name="input_domain_admin_password"></a> [domain\_admin\_password](#input\_domain\_admin\_password) | The username of the AD domain admin. | `string` | `null` | no |
| <a name="input_domain_join_agent"></a> [domain\_join\_agent](#input\_domain\_join\_agent) | Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances. | <pre>object({<br>    domain                = string<br>    domain_admin_username = string<br>    ou_path               = string<br>  })</pre> | `null` | no |
| <a name="input_enable_state_configuration_access"></a> [enable\_state\_configuration\_access](#input\_enable\_state\_configuration\_access) | Create RBAC access to state configuration storage account. | `bool` | `false` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `true` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | The host name of the VMSS instances. If provided, this will override the auto-generated host name. | `string` | `null` | no |
| <a name="input_host_name_suffix"></a> [host\_name\_suffix](#input\_host\_name\_suffix) | The suffix to be appended to the auto-generated host names of the VMSS instances | `string` | `null` | no |
| <a name="input_iaas_antimalware_agent"></a> [iaas\_antimalware\_agent](#input\_iaas\_antimalware\_agent) | Configuration settings of the Microsoft.Azure.Security.IaasAntimalware extension to be installed on the VMSS instances. | <pre>object({<br>    exclusions = object({<br>      extensions = list(string)<br>      paths      = list(string)<br>      processes  = list(string)<br>    }),<br>    scheduled_scan = object({<br>      enabled = bool<br>    })<br>  })</pre> | <pre>{<br>  "exclusions": {<br>    "extensions": [],<br>    "paths": [],<br>    "processes": []<br>  },<br>  "scheduled_scan": {<br>    "enabled": true<br>  }<br>}</pre> | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of instances to provision in the VMSS. | `number` | `null` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The size of the VMSS instances (e.g. Standard\_F2). | `string` | `null` | no |
| <a name="input_key_vault_agent"></a> [key\_vault\_agent](#input\_key\_vault\_agent) | Configuration settings of the Microsoft.Azure.KeyVault.KeyVaultForWindows extension to be installed on the VMSS instances.<br><br>It is recommended that you do not enable certificate linking when installing this extension on Service Fabric cluster nodes.<br>For more details, see: https://docs.microsoft.com/en-us/azure/service-fabric/cluster-security-certificate-management#certificate-linking-explained. | <pre>object({<br>    key_vault_id                 = string<br>    key_vault_name               = string<br>    observed_certificate_names   = list(string)<br>    link_certificates_on_renewal = bool<br>  })</pre> | `null` | no |
| <a name="input_local_admin_password"></a> [local\_admin\_password](#input\_local\_admin\_password) | The password associated with the local administrator account. | `string` | n/a | yes |
| <a name="input_local_admin_password_key_vault_id"></a> [local\_admin\_password\_key\_vault\_id](#input\_local\_admin\_password\_key\_vault\_id) | Resource ID of the Key Vault in which to store the password of the local admin account. | `string` | n/a | yes |
| <a name="input_local_admin_username"></a> [local\_admin\_username](#input\_local\_admin\_username) | Username of the local admin user account. | `string` | `"vmadmin"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the Windows Virtual Machine Scale Set should exist. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID of the Log Analytics Workspace to which the Log Analytics extension should write its logs | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_key"></a> [log\_analytics\_workspace\_key](#input\_log\_analytics\_workspace\_key) | Access Key of the Log Analytics workspace to which the Log Analytics extension should write its logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this resource. If supplied, it will override the auto-generated name. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of VMSS resource | `string` | `null` | no |
| <a name="input_nic"></a> [nic](#input\_nic) | List of network interface cards to be created for each VMSS instance. | <pre>object({<br>    subnet_id                                    = string<br>    application_gateway_backend_address_pool_ids = list(string)<br>    load_balancer_backend_address_pool_ids       = list(string)<br>    enable_accelerated_networking                = bool<br>  })</pre> | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Details of the OS Disk to be provisioned for each VMSS instance | <pre>object({<br>    type      = string<br>    size_gb   = number<br>    ephemeral = bool<br>  })</pre> | <pre>{<br>  "ephemeral": false,<br>  "size_gb": null,<br>  "type": null<br>}</pre> | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | Specifies the name of the Recovery Services Vault to use. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group in which the Windows Virtual Machine Scale Set should be exist. | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | The role of the virtual machine scale set | `string` | n/a | yes |
| <a name="input_service_fabric_agent"></a> [service\_fabric\_agent](#input\_service\_fabric\_agent) | Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances. | <pre>object({<br>    cluster_endpoint                       = string<br>    node_type                              = string<br>    fabric_root_path                       = string<br>    durability_level                       = string<br>    nic_prefix_override                    = string<br>    cluster_certificate_common_names       = list(string)<br>    reverse_proxy_certificate_common_names = list(string)<br>  })</pre> | `null` | no |
| <a name="input_service_fabric_agent_log_storage_account_keys"></a> [service\_fabric\_agent\_log\_storage\_account\_keys](#input\_service\_fabric\_agent\_log\_storage\_account\_keys) | Access keys for the log storage account to be used by the Service Fabric Agent extension. | <pre>object({<br>    primary_access_key   = string<br>    secondary_access_key = string<br>  })</pre> | `null` | no |
| <a name="input_state_configuration_storage_account_id"></a> [state\_configuration\_storage\_account\_id](#input\_state\_configuration\_storage\_account\_id) | The storage account id within which state configuration assets reside. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resources. | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The time zone which should be used by the virtual machine | `string` | `"UTC"` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | When changes are made to the scale set model, how should those changes be rolled out to all instances? | `string` | `"Manual"` | no |
| <a name="input_user_assigned_managed_identity_name"></a> [user\_assigned\_managed\_identity\_name](#input\_user\_assigned\_managed\_identity\_name) | The name of a user assigned managed identity that this VM should use when authenticating to Azure resources | `string` | `null` | no |
| <a name="input_user_assigned_managed_identity_objectid"></a> [user\_assigned\_managed\_identity\_objectid](#input\_user\_assigned\_managed\_identity\_objectid) | The ObjectID of a user assigned managed identity that this VM should use when authenticating to Azure resources | `string` | `null` | no |
| <a name="input_windows_image_offer"></a> [windows\_image\_offer](#input\_windows\_image\_offer) | The windows offer to be used. This maps to the 'offer' field in ARM. | `string` | `"WindowsServer"` | no |
| <a name="input_windows_image_publisher"></a> [windows\_image\_publisher](#input\_windows\_image\_publisher) | The publisher of the Windows image to be used | `string` | `"MicrosoftWindowsServer"` | no |
| <a name="input_windows_image_sku"></a> [windows\_image\_sku](#input\_windows\_image\_sku) | The sku of windows image to be used. This maps to the 'sku' field in ARM. | `string` | `"2019-Datacenter"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created. Changing this forces a new resource to be created. | `list(number)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Resource ID of the Windows Virtual Machine Scale Set. |
| <a name="output_managed_identity"></a> [managed\_identity](#output\_managed\_identity) | Details of the managed identity under which the virtual machine scale set is configured to run. |
| <a name="output_name"></a> [name](#output\_name) | The name of the virtual machine scale set. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The Unique ID for this Windows Virtual Machine Scale Set. |
<!-- END_TF_DOCS -->