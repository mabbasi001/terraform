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
| [azurerm_automation_module.cpce_automation_account_module](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_module) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | The automation account which will use the modules | `string` | n/a | yes |
| <a name="input_content_link"></a> [content\_link](#input\_content\_link) | Link to consume module | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the module | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group this resource will be put | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->