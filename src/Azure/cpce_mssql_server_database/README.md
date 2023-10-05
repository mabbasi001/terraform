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
| [azurerm_mssql_database.cpce_sql_server_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collation"></a> [collation](#input\_collation) | Specifies the collation of the database. Changing this forces a new resource to be created. | `string` | `"Latin1_General_CI_AS"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_elastic_pool_id"></a> [elastic\_pool\_id](#input\_elastic\_pool\_id) | Specifies the ID of the elastic pool containing this database. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice. | `string` | `"LicenseIncluded"` | no |
| <a name="input_long_term_retention_policy"></a> [long\_term\_retention\_policy](#input\_long\_term\_retention\_policy) | Details of the (optional) long term retention policy. | <pre>map(object({<br>    weekly_retention  = bool<br>    monthly_retention = string<br>    yearly_retention  = string<br>    week_of_year      = number<br>  }))</pre> | `null` | no |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The max size of the database in gigabytes. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the sql server | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_read_scale"></a> [read\_scale](#input\_read\_scale) | If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases. | `bool` | `false` | no |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | The id of the MS SQL Server on which to create the database. | `string` | `null` | no |
| <a name="input_short_term_retention_policy"></a> [short\_term\_retention\_policy](#input\_short\_term\_retention\_policy) | Details of the (optional) short term retention policy. | <pre>map(object({<br>    retention_days = number<br>  }))</pre> | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the name of the SKU used by the database. | `string` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_threat_detection_policy"></a> [threat\_detection\_policy](#input\_threat\_detection\_policy) | Threat detection policy configuration. | <pre>map(object({<br>    state                      = bool<br>    disabled_alerts            = string<br>    email_account_admins       = string<br>    email_addresses            = list(string)<br>    retention_days             = number<br>    storage_account_access_key = string<br>    storage_endpoint           = string<br>  }))</pre> | `null` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure SQL Database |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure SQL Server |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are on this resource |
<!-- END_TF_DOCS -->