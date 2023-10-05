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
| [azurerm_mssql_server.cpce_sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_auth_only"></a> [aad\_auth\_only](#input\_aad\_auth\_only) | Specifies whether only AD Users and administrators can be used to login or also local database users. | `bool` | `true` | no |
| <a name="input_aad_login_object_id"></a> [aad\_login\_object\_id](#input\_aad\_login\_object\_id) | The object id of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_aad_login_tenant_id"></a> [aad\_login\_tenant\_id](#input\_aad\_login\_tenant\_id) | The tenant id of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_aad_login_username"></a> [aad\_login\_username](#input\_aad\_login\_username) | The login username of the Azure AD Administrator of this SQL Server. | `string` | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password associated with the sql server administrator account. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Username of the sql server of admin account. | `string` | `"sqladmin"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Identity IDs to be assigned. Required if identity\_type is UserAssigned. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Specifies the identity type of the Microsoft SQL Server. Possible values are SystemAssigned and UserAssigned where you can specify the Service Principal IDs in the user\_assigned\_identity\_ids field. | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The Minimum TLS Version. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the sql server | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_primary_user_assigned_identity_id"></a> [primary\_user\_assigned\_identity\_id](#input\_primary\_user\_assigned\_identity\_id) | Specifies the primary user managed identity id. Required if type is UserAssigned and should be combined with user\_assigned\_identity\_ids. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure SQL Server |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The Principal ID for the Service Principal associated with the Identity of this SQL Server. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Azure SQL Server |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure SQL Server |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are on this resource |
<!-- END_TF_DOCS -->