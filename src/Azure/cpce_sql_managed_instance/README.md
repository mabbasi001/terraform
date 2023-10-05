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
| [azurerm_sql_managed_instance.cpce_sqlmi](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_managed_instance) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_admin_identity_name"></a> [aad\_admin\_identity\_name](#input\_aad\_admin\_identity\_name) | Name of the identity of AAD amin. | `string` | `null` | no |
| <a name="input_aad_admin_object_id"></a> [aad\_admin\_object\_id](#input\_aad\_admin\_object\_id) | Object ID of identity of AAD admin. | `string` | `null` | no |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | Username of the local admin user account. | `string` | `"sqladmin"` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The password associated with the local administrator account. | `string` | n/a | yes |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | Specifies whether only AD Users and administrators can be used to login (true) or also local database users (false). | `bool` | `false` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Specifies how the SQL Managed Instance will be collated. | `string` | `"Latin1_General_CI_AS"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_dns_zone_partner_id"></a> [dns\_zone\_partner\_id](#input\_dns\_zone\_partner\_id) | The ID of the Managed Instance which will share the DNS zone. This is a prerequisite for creating a azurerm\_sql\_managed\_instance\_failover\_group. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | What type of license the Managed Instance will use. | `string` | `"LicenseIncluded"` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The Minimum TLS Version. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the apim resource. If provided, this will override the auto-generated name. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of both the resource and host | `string` | `null` | no |
| <a name="input_proxy_override"></a> [proxy\_override](#input\_proxy\_override) | pecifies how the SQL Managed Instance will be accessed. | `string` | `"Proxy"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this resource should exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity | `string` | `"GP_Gen5"` | no |
| <a name="input_storage_size_in_gb"></a> [storage\_size\_in\_gb](#input\_storage\_size\_in\_gb) | Maximum storage space for your instance. It should be a multiple of 32GB. | `number` | `32` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet to associate this Managed Instance to. | `string` | `null` | no |
| <a name="input_timezone_id"></a> [timezone\_id](#input\_timezone\_id) | The TimeZone ID that the SQL Managed Instance will be operating in. | `string` | `"UTC"` | no |
| <a name="input_vcores"></a> [vcores](#input\_vcores) | Number of cores that should be assigned to your instance. | `number` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the Azure Managed SQL Instance. |
| <a name="output_id"></a> [id](#output\_id) | The SQL Managed Instance ID. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID for the Service Principal associated with the Identity of this SQL Managed Instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the managed instance. |
<!-- END_TF_DOCS -->