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
| [azurerm_advanced_threat_protection.cpce_storage_account_threat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_monitor_diagnostic_setting.cpce_storage_account_blob_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.cpce_storage_account_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.cpce_storage_account_file_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.cpce_storage_account_queue_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.cpce_storage_account_table_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.cpce_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_management_policy.cpce_storage_account_management_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_monitor_diagnostic_categories.storage_blob_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.storage_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.storage_file_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.storage_queue_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_monitor_diagnostic_categories.storage_table_diagnostic_categories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts | `string` | `null` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | The kind of account to create | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `null` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. | `bool` | `false` | no |
| <a name="input_azure_monitor_diagnostic_setting"></a> [azure\_monitor\_diagnostic\_setting](#input\_azure\_monitor\_diagnostic\_setting) | n/a | <pre>object({<br>    enable                     = bool<br>    log_analytics_workspace_id = string<br><br>    # the number of days for which this Retention Policy should apply.<br>    # Setting this to 0 will retain the events indefinitely.<br>    retention_policy_days = number<br>  })</pre> | <pre>{<br>  "enable": false,<br>  "log_analytics_workspace_id": null,<br>  "retention_policy_days": null<br>}</pre> | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_disable_sa_diagnostic_retention_in_days"></a> [disable\_sa\_diagnostic\_retention\_in\_days](#input\_disable\_sa\_diagnostic\_retention\_in\_days) | Flag to disable usage of storage account retention in days - required for new diagnostic settings due to MS phased deprecation of legacy retention model. | `bool` | `false` | no |
| <a name="input_enable_delete_lifecycle_rule"></a> [enable\_delete\_lifecycle\_rule](#input\_enable\_delete\_lifecycle\_rule) | Enable the creation of a delete lifecycle rule | `bool` | `false` | no |
| <a name="input_enable_static_website"></a> [enable\_static\_website](#input\_enable\_static\_website) | Enable static website | `bool` | `false` | no |
| <a name="input_enable_threat_protection"></a> [enable\_threat\_protection](#input\_enable\_threat\_protection) | Enable threat protection on storage account resource | `bool` | `true` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_management_policy_delete_retention_days"></a> [management\_policy\_delete\_retention\_days](#input\_management\_policy\_delete\_retention\_days) | Number of days to retain before deleting blob files (This resource creation is behind (enable\_delete\_lifecycle\_rule = true)) | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | The override name for the resource | `any` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | An object to specify an array of subnet that have service level access. | <pre>object({<br>    default_action             = string<br>    virtual_network_subnet_ids = list(string)   <br>  })</pre> | `null` | no |
| <a name="input_private_link_access"></a> [private\_link\_access](#input\_private\_link\_access) | Network rule private link access | <pre>map(object({<br>    endpoint_resource_id = string<br>    endpoint_tenant_id   = string<br>  }))</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group this resource will be put | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Allow or disallow access to the storage account with a shared key (including shared access signature (SAS)) | `bool` | `true` | no |
| <a name="input_static_website_index_page"></a> [static\_website\_index\_page](#input\_static\_website\_index\_page) | Static website index page | `string` | `null` | no |
| <a name="input_storage_blob_cors_rule"></a> [storage\_blob\_cors\_rule](#input\_storage\_blob\_cors\_rule) | Details of the required Service Fabric client certificates. | <pre>map(object({<br>    allowed_headers    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_origins    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = number<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_tier"></a> [access\_tier](#output\_access\_tier) | n/a |
| <a name="output_account_kind"></a> [account\_kind](#output\_account\_kind) | n/a |
| <a name="output_account_tier"></a> [account\_tier](#output\_account\_tier) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | n/a |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | n/a |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | n/a |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | n/a |
| <a name="output_primary_location"></a> [primary\_location](#output\_primary\_location) | n/a |
| <a name="output_primary_queue_endpoint"></a> [primary\_queue\_endpoint](#output\_primary\_queue\_endpoint) | n/a |
| <a name="output_primary_table_endpoint"></a> [primary\_table\_endpoint](#output\_primary\_table\_endpoint) | n/a |
| <a name="output_primary_web_endpoint"></a> [primary\_web\_endpoint](#output\_primary\_web\_endpoint) | n/a |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | n/a |
| <a name="output_secondary_blob_endpoint"></a> [secondary\_blob\_endpoint](#output\_secondary\_blob\_endpoint) | n/a |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | n/a |
| <a name="output_secondary_file_endpoint"></a> [secondary\_file\_endpoint](#output\_secondary\_file\_endpoint) | n/a |
| <a name="output_secondary_location"></a> [secondary\_location](#output\_secondary\_location) | n/a |
| <a name="output_secondary_queue_endpoint"></a> [secondary\_queue\_endpoint](#output\_secondary\_queue\_endpoint) | n/a |
| <a name="output_secondary_table_endpoint"></a> [secondary\_table\_endpoint](#output\_secondary\_table\_endpoint) | n/a |
<!-- END_TF_DOCS -->