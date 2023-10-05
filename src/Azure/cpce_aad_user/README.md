<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_user.cpce_aad_user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the AAD user being created. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | The password used at creation for the AAD user being created. | `string` | n/a | yes |
| <a name="input_user_principal_name"></a> [user\_principal\_name](#input\_user\_principal\_name) | The fully qualified domain name of the AAD user being created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The Domain Name of the AAD user being created. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The ObjectID of the AAD user being created. |
| <a name="output_user_principal_name"></a> [user\_principal\_name](#output\_user\_principal\_name) | The Domain User Principal Name of the AAD user being created. |
<!-- END_TF_DOCS -->