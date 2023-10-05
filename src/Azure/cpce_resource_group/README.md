<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | ~>1.2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | ~>1.2.23 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_resource_group.cpce_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_generate_azurecaf_name"></a> [generate\_azurecaf\_name](#input\_generate\_azurecaf\_name) | Determines whether the resource should use the AzureCAF name generation (true) or use the custom CPCE method (false). | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The Name which should be used for this resource it will override the concaternated one | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the Resource Group. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID resource group |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region where the Resource Group exists |
| <a name="output_name"></a> [name](#output\_name) | The name resource group |
<!-- END_TF_DOCS -->