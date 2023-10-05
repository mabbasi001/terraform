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
| [azurerm_automation_account.cpce_automation_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment in which the resource is being created | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_managed_identity"></a> [managed\_identity](#input\_managed\_identity) | Assign a Managed Identity to the resource. | `string` | `"SystemAssigned"` | no |
| <a name="input_name"></a> [name](#input\_name) | The override name for the resource | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group this resource will be put | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for Automation Account. Possible value is Basic | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dsc_primary_access_key"></a> [dsc\_primary\_access\_key](#output\_dsc\_primary\_access\_key) | n/a |
| <a name="output_dsc_secondary_access_key"></a> [dsc\_secondary\_access\_key](#output\_dsc\_secondary\_access\_key) | n/a |
| <a name="output_dsc_server_endpoint"></a> [dsc\_server\_endpoint](#output\_dsc\_server\_endpoint) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->