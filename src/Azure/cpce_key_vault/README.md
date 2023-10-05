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
| [azurerm_key_vault.cpce_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contacts"></a> [contacts](#input\_contacts) | A map of contacts that should be notified of impending certificate expirations. | <pre>map(object({<br>    name  = string<br>    email = string<br>    phone = string<br>  }))</pre> | `{}` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the key vault | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Purge Protection switch for this Key Vault. | `bool` | `null` | no |
| <a name="input_quality"></a> [quality](#input\_quality) | The quality level of the hub resources to be provisioned. | `string` | `"DEV"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days for which soft-deleted items should be retained. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The ID of the Azure Active Directory tenant that should be used for authenticating requests to this resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_for_deployment"></a> [enabled\_for\_deployment](#output\_enabled\_for\_deployment) | Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault |
| <a name="output_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#output\_enabled\_for\_disk\_encryption) | Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys |
| <a name="output_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#output\_enabled\_for\_template\_deployment) | Azure Resource Manager is permitted to retrieve secrets from the key vault |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault |
| <a name="output_location"></a> [location](#output\_location) | The location of the Key Vault |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The sku of the Key Vault |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are on this resource |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
<!-- END_TF_DOCS -->