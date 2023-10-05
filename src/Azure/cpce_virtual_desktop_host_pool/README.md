<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_desktop_host_pool.avdhostpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [time_static.time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_rdp_properties"></a> [custom\_rdp\_properties](#input\_custom\_rdp\_properties) | (Optional) A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be found here - https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/rdp-files. | `string` | `"redirectsmartcards:i:0;usbdevicestoredirect:s:*;multimon:i:0;screen mode id:i:1;smart sizing:i:1;redirectclipboard:i:1;drivestoredirect:s:*;"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Virtual Desktop Host Pool. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | (Optional) A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled. | `string` | `"DepthFirst"` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_maximum_sessions_allowed"></a> [maximum\_sessions\_allowed](#input\_maximum\_sessions\_allowed) | (Optional) A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource, by default it uses a collection of name,customer code, enviroment code and name sufix to populate the name. But you can override if needed to change the overall name | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of both the resource and host | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this virtual machine should exist. | `string` | n/a | yes |
| <a name="input_start_vm_on_connect"></a> [start\_vm\_on\_connect](#input\_start\_vm\_on\_connect) | (Optional) Enables or disables the Start VM on Connection Feature. Defaults to false. | `string` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the Virtual Desktop Host Pool. Valid options are Personal or Pooled. Changing the type forces a new resource to be created. | `string` | `"Pooled"` | no |
| <a name="input_validate_environment"></a> [validate\_environment](#input\_validate\_environment) | (Optional) Allows you to test service changes before they are deployed to production. Defaults to false | `string` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Host pool Id |
| <a name="output_name"></a> [name](#output\_name) | Host pool token |
<!-- END_TF_DOCS -->