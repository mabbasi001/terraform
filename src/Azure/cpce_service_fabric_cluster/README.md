<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fabric_logs_storage_account"></a> [fabric\_logs\_storage\_account](#module\_fabric\_logs\_storage\_account) | ../cpce_storage_account | n/a |
| <a name="module_internal_load_balancer"></a> [internal\_load\_balancer](#module\_internal\_load\_balancer) | ../cpce_load_balancer | n/a |
| <a name="module_scale_sets"></a> [scale\_sets](#module\_scale\_sets) | ../cpce_windows_virtual_machine_scale_set | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.service_fabric_client](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.service_fabric_cluster](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_pre_authorized.client_pre_authorized_to_cluster](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_pre_authorized) | resource |
| [azuread_service_principal.service_fabric_client](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.service_fabric_cluster](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_key_vault_certificate.cluster_certificates](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_service_fabric_cluster.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_fabric_cluster) | resource |
| [random_uuid.service_fabric_cluster_admin_role_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.service_fabric_cluster_user_impersonation_scope_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.service_fabric_cluster_user_role_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azuread_application.service_fabric_client](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_application.service_fabric_cluster](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_tenant_id"></a> [authentication\_tenant\_id](#input\_authentication\_tenant\_id) | ID of the tenant that will be authenticating access to the service fabric cluster | `string` | n/a | yes |
| <a name="input_azure_devops_agent_pool_name"></a> [azure\_devops\_agent\_pool\_name](#input\_azure\_devops\_agent\_pool\_name) | Azure DevOps Agent pool for Virtual Machine State Configuration. | `string` | `null` | no |
| <a name="input_azure_devops_organization"></a> [azure\_devops\_organization](#input\_azure\_devops\_organization) | Target Azure DevOps Organization for Virtual Machine State Configuration. | `string` | n/a | yes |
| <a name="input_azure_devops_pool_agent_pat"></a> [azure\_devops\_pool\_agent\_pat](#input\_azure\_devops\_pool\_agent\_pat) | The PAT that the Azure Devops Deployment Group agent will use to register with the Deployment Group. | `string` | `null` | no |
| <a name="input_azure_devops_product_agent_pool_name"></a> [azure\_devops\_product\_agent\_pool\_name](#input\_azure\_devops\_product\_agent\_pool\_name) | Azure DevOps Agent pool for Product Deployments. | `string` | `null` | no |
| <a name="input_azure_devops_product_organization"></a> [azure\_devops\_product\_organization](#input\_azure\_devops\_product\_organization) | Target Azure DevOps Organization for Product Deployments. | `string` | `null` | no |
| <a name="input_azure_devops_product_project"></a> [azure\_devops\_product\_project](#input\_azure\_devops\_product\_project) | Target Azure DevOps Project for Product Deployments. | `string` | `null` | no |
| <a name="input_azure_devops_project"></a> [azure\_devops\_project](#input\_azure\_devops\_project) | Target Azure DevOps Project for Virtual Machine State Configuration. | `string` | n/a | yes |
| <a name="input_client_certificates"></a> [client\_certificates](#input\_client\_certificates) | Details of the required Service Fabric client certificates. | <pre>map(object({<br>    common_name       = string<br>    issuer_thumbprint = string<br>    is_admin          = bool<br>  }))</pre> | `{}` | no |
| <a name="input_cluster_certificate_notification_days_before_expiry"></a> [cluster\_certificate\_notification\_days\_before\_expiry](#input\_cluster\_certificate\_notification\_days\_before\_expiry) | Number of days before the certificates' expiry dates when a notification will be generated. | `number` | `90` | no |
| <a name="input_cluster_certificate_pfx_passwords"></a> [cluster\_certificate\_pfx\_passwords](#input\_cluster\_certificate\_pfx\_passwords) | Password of the pfx file containing the Service Fabric cluster certificates.<br>Note: The keys must match those defined in the cluster\_certificates map. | `map(string)` | n/a | yes |
| <a name="input_cluster_certificates"></a> [cluster\_certificates](#input\_cluster\_certificates) | Details of the required Service Fabric cluster certificates.<br><br>Note: If more than one cluster or reverse proxy certificate is specified, the cluster will use whichever one has latest start date (not the latest expiry date!). | <pre>map(object({<br>    type              = string<br>    pfx_path          = string<br>    common_name       = string<br>    issuer_thumbprint = string<br>    key_type          = string<br>    key_size          = number<br>  }))</pre> | n/a | yes |
| <a name="input_cluster_management_uri"></a> [cluster\_management\_uri](#input\_cluster\_management\_uri) | The URI of the Service Fabric cluster. Used to construct the full management endpoint URLs. | `string` | n/a | yes |
| <a name="input_cluster_os_type"></a> [cluster\_os\_type](#input\_cluster\_os\_type) | The type of OS that the VMSSs have been configured with. Generic names such as Windows or Linux can be used. | `string` | `"Windows"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Specifies the Version of the Cluster Code of the cluster. Required if Upgrade Mode set to Manual. Ignored otherwise. | `string` | `null` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_deploy_sf_azure_ad_app"></a> [deploy\_sf\_azure\_ad\_app](#input\_deploy\_sf\_azure\_ad\_app) | Deploy Azure AD app regs? | `bool` | `true` | no |
| <a name="input_devops_agent_script_url"></a> [devops\_agent\_script\_url](#input\_devops\_agent\_script\_url) | Download URL for the DevOps Agent Pool Script. | `string` | n/a | yes |
| <a name="input_disable_iaas_extension"></a> [disable\_iaas\_extension](#input\_disable\_iaas\_extension) | Optionally disable Iaas Anti-Malware Extension, allows for deferred addition of the extension within Enterprise Dev/Test offers. | `bool` | `false` | no |
| <a name="input_domain_admin_password"></a> [domain\_admin\_password](#input\_domain\_admin\_password) | The username of the AD domain admin. | `string` | `null` | no |
| <a name="input_enable_state_configuration_access"></a> [enable\_state\_configuration\_access](#input\_enable\_state\_configuration\_access) | Create RBAC access to state configuration storage account. | `bool` | `false` | no |
| <a name="input_enable_threat_protection"></a> [enable\_threat\_protection](#input\_enable\_threat\_protection) | Enable threat protection on storage account resource | `bool` | `true` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT'). | `string` | `null` | no |
| <a name="input_environment_location_short_code"></a> [environment\_location\_short\_code](#input\_environment\_location\_short\_code) | A short location identifier for environment, a 3 letter version the the region code | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created. | `string` | n/a | yes |
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | The name of the virtual machine host. If provided, this will override the auto-generated host name. | `string` | `null` | no |
| <a name="input_http_administration_endpoint_port"></a> [http\_administration\_endpoint\_port](#input\_http\_administration\_endpoint\_port) | Port to use when connecting to the Cluster Explorer web UI | `number` | `19080` | no |
| <a name="input_internal_load_balancer"></a> [internal\_load\_balancer](#input\_internal\_load\_balancer) | Details of the internal load balancer to be created for this Service Fabric cluster | <pre>object({<br>    subnet_id                        = string<br>    tcp_administration_gateway_port  = number<br>    http_administration_gateway_port = number<br>    reverse_proxy_gateway_port       = number<br>    private_ip_address               = string<br>    sku_name                         = string<br>  })</pre> | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Details of the Key Vault containing the cluster/reverse proxy certificates. The password of the virtual machine admin user will also be added to this vault. | <pre>object({<br>    id   = string<br>    name = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Resource ID of the Log Analytics Workspace to which all the Log Analytics extensions should write their logs. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_key"></a> [log\_analytics\_workspace\_key](#input\_log\_analytics\_workspace\_key) | Access Key of the Log Analytics workspace to which all the Log Analytics extensions should write their logs. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Service Fabric cluster. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource. | `string` | `null` | no |
| <a name="input_node_types"></a> [node\_types](#input\_node\_types) | Details of the node types needed in the Service Fabric Cluster | <pre>map(object({<br>    subnet = object({<br>      id               = string<br>      name             = string<br>      address_prefixes = list(string)<br>    })<br>    instance_count       = number<br>    instance_size        = string<br>    is_primary           = bool<br>    timezone             = string<br>    placement_properties = map(string)<br>    capacity_tags        = map(string)<br>    durability_level     = string<br>    os_disk = object({<br>      type    = string<br>      size_gb = number<br>    })<br>    application_ports = object({<br>      start_port = number<br>      end_port   = number<br>    })<br>    ephemeral_ports = object({<br>      start_port = number<br>      end_port   = number<br>    })<br>    enable_accelerated_networking = bool<br>  }))</pre> | n/a | yes |
| <a name="input_reliability_level"></a> [reliability\_level](#input\_reliability\_level) | The reliability level of the Service Fabric Cluster. This dictates the number the 'seed nodes' in the primary node type. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_reverse_proxy_endpoint_port"></a> [reverse\_proxy\_endpoint\_port](#input\_reverse\_proxy\_endpoint\_port) | The port on which the reverse proxy service will expose itself from the cluster | `number` | `19081` | no |
| <a name="input_service_fabric_client_app_reg_display_name"></a> [service\_fabric\_client\_app\_reg\_display\_name](#input\_service\_fabric\_client\_app\_reg\_display\_name) | An override for the auto-generated display name of the App Registration representing a client application that is calling the Service Fabric Cluster | `string` | `null` | no |
| <a name="input_service_fabric_cluster_app_reg_display_name"></a> [service\_fabric\_cluster\_app\_reg\_display\_name](#input\_service\_fabric\_cluster\_app\_reg\_display\_name) | An override for the auto-generated display name of the App Registration representing the Service Fabric Cluster | `string` | `null` | no |
| <a name="input_short_environment_code"></a> [short\_environment\_code](#input\_short\_environment\_code) | A shorter environment code, applied to resources with naming restrictions | `string` | `null` | no |
| <a name="input_state_configuration_storage_account_id"></a> [state\_configuration\_storage\_account\_id](#input\_state\_configuration\_storage\_account\_id) | The storage account id within which state configuration assets reside. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resources. | `map(string)` | `{}` | no |
| <a name="input_targets_secondary_region"></a> [targets\_secondary\_region](#input\_targets\_secondary\_region) | Is this targeting the secondary region for DR? | `bool` | `false` | no |
| <a name="input_tcp_administration_endpoint_port"></a> [tcp\_administration\_endpoint\_port](#input\_tcp\_administration\_endpoint\_port) | Port to use when connecting to the cluster using a TCP connection (e.g. when using the Service Fabric PowerShell module). | `number` | `19000` | no |
| <a name="input_upgrade_mode"></a> [upgrade\_mode](#input\_upgrade\_mode) | Upgrade mode of the cluster. | `string` | `"Manual"` | no |
| <a name="input_user_assigned_managed_identity_name"></a> [user\_assigned\_managed\_identity\_name](#input\_user\_assigned\_managed\_identity\_name) | The name of a user assigned managed identity that this VM should use when authenticating to Azure resources | `string` | `null` | no |
| <a name="input_vmss_local_admin_password"></a> [vmss\_local\_admin\_password](#input\_vmss\_local\_admin\_password) | The password associated with VMSS local administrator account. | `string` | n/a | yes |
| <a name="input_windows_ad_domain"></a> [windows\_ad\_domain](#input\_windows\_ad\_domain) | Configuration settings of the Microsoft.Azure.ServiceFabric extension to be installed on the VMSS instances. | <pre>object({<br>    domain                = string<br>    domain_admin_username = string<br>    ou_path               = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The cluster endpoint of the Azure Service Fabric Cluster. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Service Fabric Cluster |
| <a name="output_load_balancer"></a> [load\_balancer](#output\_load\_balancer) | Details of the internal Load Balancer that's in front of the Azure Service Fabric Cluster. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Service Fabric Cluster |
| <a name="output_cpce_cluster_certificate"></a> [cpce\_cluster\_certificate](#output\_cpce\_cluster\_certificate) | Details of the Cluster Certificate. |
| <a name="output_cpce_encipherment_primary_certificate"></a> [cpce\_encipherment\_primary\_certificate](#output\_cpce\_encipherment\_primary\_certificate) | Details of the Primary Encipherment Certificate. |
| <a name="output_cpce_reverse_proxy_certificate"></a> [cpce\_reverse\_proxy\_certificate](#output\_cpce\_reverse\_proxy\_certificate) | Details of the Reverse Proxy Certificate. |
| <a name="output_virtual_machine_scale_sets"></a> [virtual\_machine\_scale\_sets](#output\_virtual\_machine\_scale\_sets) | A list of the virtual machine scale sets created to support each of the node types required by the Azure Service Fabric Cluster. |
<!-- END_TF_DOCS -->