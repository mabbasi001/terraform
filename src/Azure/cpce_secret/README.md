<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.secret_encrypted](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.secret_encrypted_environment_manager](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault.environment_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [external_external.encrypted_secret](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.encrypted_secret_environment_manager](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.firstfivecharthumbprint](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_thumbprint"></a> [certificate\_thumbprint](#input\_certificate\_thumbprint) | thumbprint of encipherment certificate | `string` | `null` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | How we want to encrypt the secret, allowed options are "none", "encipherment\_certificate", "environment\_manager". | `string` | n/a | yes |
| <a name="input_environment_keyvault"></a> [environment\_keyvault](#input\_environment\_keyvault) | key vault name | `string` | n/a | yes |
| <a name="input_environment_keyvault_resource_group"></a> [environment\_keyvault\_resource\_group](#input\_environment\_keyvault\_resource\_group) | key vault resource group | `string` | n/a | yes |
| <a name="input_cpcedataenciphermentcertificatepath"></a> [cpcedataenciphermentcertificatepath](#input\_cpcedataenciphermentcertificatepath) | secure\_file\_path | `string` | `null` | no |
| <a name="input_secret_is_managed_resource"></a> [secret\_is\_managed\_resource](#input\_secret\_is\_managed\_resource) | when set to true, secret will be managed by this terraform as a resource | `bool` | `true` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | secret name in keyvault. | `string` | n/a | yes |
| <a name="input_secret_value"></a> [secret\_value](#input\_secret\_value) | Secret value -<br>    If provided, a secret \"resource\" will be created by this terraform, and the value of such resource will not be updated other than the initial creation.<br>    If not provided, the encryption will be based on the secret retrieved from the \"data source\" where secret name = var.secret\_name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_encrypted_encipherment_certificate"></a> [secret\_encrypted\_encipherment\_certificate](#output\_secret\_encrypted\_encipherment\_certificate) | The encipherment certificate encrypted secret |
| <a name="output_secret_encrypted_encipherment_certificate_name"></a> [secret\_encrypted\_encipherment\_certificate\_name](#output\_secret\_encrypted\_encipherment\_certificate\_name) | The name of the encipherment certificate encrypted secret |
| <a name="output_secret_encrypted_environment_manager"></a> [secret\_encrypted\_environment\_manager](#output\_secret\_encrypted\_environment\_manager) | The environment manager encrypted secret. |
| <a name="output_secret_encrypted_environment_manager_name"></a> [secret\_encrypted\_environment\_manager\_name](#output\_secret\_encrypted\_environment\_manager\_name) | The name of the environment manager encrypted secret. |
<!-- END_TF_DOCS -->