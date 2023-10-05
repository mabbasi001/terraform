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
| [azurerm_availability_set.cpce_availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_fault_domain_count"></a> [fault\_domain\_count](#input\_fault\_domain\_count) | The number of fault domains across which the VMs should be distributed. | `number` | `2` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the Windows Virtual Machine Scale Set should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The Name which should be used for this resource, it will override the auto-generated name one. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group in which the Windows Virtual Machine Scale Set should be exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_update_domain_count"></a> [update\_domain\_count](#input\_update\_domain\_count) | The number of update domains across which the VMs should be distributed. | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fault_domain_count"></a> [fault\_domain\_count](#output\_fault\_domain\_count) | The fault\_domain\_count of the Availability Set. |
| <a name="output_id"></a> [id](#output\_id) | The id of the Availability Set. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Availability Set. |
| <a name="output_update_domain_count"></a> [update\_domain\_count](#output\_update\_domain\_count) | The update\_domain\_count of the Availability Set. |
<!-- END_TF_DOCS -->