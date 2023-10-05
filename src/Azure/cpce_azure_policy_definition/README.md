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
| [azurerm_policy_definition.cpce_azure_policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the policy definition. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the policy definition. | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The id of the Management Group where this policy should be defined. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. | `string` | `null` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The policy mode that allows you to specify which resource types will be evaluated. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Policy Assignment. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition. | `string` | `null` | no |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. | `string` | `null` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | The policy type. Possible values are BuiltIn, Custom and NotSpecified. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition_id"></a> [definition\_id](#output\_definition\_id) | n/a |
<!-- END_TF_DOCS -->