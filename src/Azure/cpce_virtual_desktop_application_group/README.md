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
| [azurerm_virtual_desktop_application_group.avdappgroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Virtual Desktop Host Pool. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_group_type"></a> [group\_type](#input\_group\_type) | The group\_type is to show if it's either a app or desktop group | `string` | `null` | no |
| <a name="input_host_pool_id"></a> [host\_pool\_id](#input\_host\_pool\_id) | (Required) Resource ID for a Virtual Desktop Host Pool to associate with the Virtual Desktop Application Group. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource, by default it uses a collection of name,customer code, enviroment code and name sufix to populate the name. But you can override if needed to change the overall name | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this virtual machine should exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop application groups. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Virtual Desktop Application Group's Id |
<!-- END_TF_DOCS -->