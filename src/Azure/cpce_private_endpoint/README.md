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
| [azurerm_private_endpoint.cpce_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the sql server | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_private_connection_approval_is_manual"></a> [private\_connection\_approval\_is\_manual](#input\_private\_connection\_approval\_is\_manual) | Does the Private Endpoint require Manual Approval from the remote resource owner? | `bool` | `false` | no |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. | `string` | `null` | no |
| <a name="input_private_connection_subresource_names"></a> [private\_connection\_subresource\_names](#input\_private\_connection\_subresource\_names) | A list of subresource names which the Private Endpoint is able to connect to.  Examples include; sqlServer, blob, file.<br>Full list here: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource. | `list(string)` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | List of private dns zones to associate to. | `list(string)` | `null` | no |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Specifies the Name of the Private DNS Zone Group. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_identifier"></a> [resource\_identifier](#input\_resource\_identifier) | The code of the resource identifier in the name | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The name of the subnet to associate this private endpoint to. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the resource |
| <a name="output_location"></a> [location](#output\_location) | The location of the resource |
| <a name="output_name"></a> [name](#output\_name) | The name of the resource |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the network interface associated to the resource. |
| <a name="output_private_dns_zone_group_id"></a> [private\_dns\_zone\_group\_id](#output\_private\_dns\_zone\_group\_id) | The ID of the private dns zone associated to the resource. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the private endpoint. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are on this resource |
<!-- END_TF_DOCS -->