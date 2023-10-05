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
| [azurerm_key_vault_secret.cpce_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | Specifies the value of the Key Vault Secret. | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault where the Secret should be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the key vault secret. | `map(string)` | `{}` | no |
| <a name="input_value"></a> [value](#input\_value) | Specifies the value of the Key Vault Secret. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Key Vault Secret ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault Secret. |
| <a name="output_version"></a> [version](#output\_version) | The current version of the Key Vault Secret. |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | The Base ID of the Key Vault Secret. |
<!-- END_TF_DOCS -->