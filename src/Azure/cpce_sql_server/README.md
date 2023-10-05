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
| [azurerm_sql_server.cpce_sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password associated with the sql server administrator account. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Username of the sql server of admin account. | `string` | `"sqladmin"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the sql server | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure SQL Server |
| <a name="output_location"></a> [location](#output\_location) | The location of the Azure SQL Server |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure SQL Server |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are on this resource |
<!-- END_TF_DOCS -->