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
| [azurerm_resource_group_policy_assignment.cpce_azure_resource_group_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description to use for this Policy Assignment. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A friendly display name to use for this Policy Assignment. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Policy Assignment. Possible values are SystemAssigned (where Azure will generate a Service Principal for you), or None (no use of a Managed Service Identity). | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where this policy assignment should exist. This is required when an Identity is SystemAssigned. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Policy Assignment. | `string` | n/a | yes |
| <a name="input_policy_definition_id"></a> [policy\_definition\_id](#input\_policy\_definition\_id) | The ID of the Policy Definition to be applied at the specified Scope. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the Resource Group where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assignment_id"></a> [assignment\_id](#output\_assignment\_id) | n/a |
<!-- END_TF_DOCS -->