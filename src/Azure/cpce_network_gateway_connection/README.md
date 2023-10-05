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
| [azurerm_local_network_gateway.cpce_local_network_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.cpce_network_gateway_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorization_key"></a> [authorization\_key](#input\_authorization\_key) | (Optional) The authorization key associated with the Express Route Circuit. | `string` | `null` | no |
| <a name="input_connection_protocol"></a> [connection\_protocol](#input\_connection\_protocol) | The IKE protocol version to use. Possible values are IKEv1 and IKEv2 | `string` | `"IKEv2"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_dpd_timeout_seconds"></a> [dpd\_timeout\_seconds](#input\_dpd\_timeout\_seconds) | (Optional) The dead peer detection timeout of this connection in seconds. | `number` | `45` | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | (Optional) If true, BGP (Border Gateway Protocol) is enabled for this connection. Defaults to false | `string` | `false` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_express_route_circuit_id"></a> [express\_route\_circuit\_id](#input\_express\_route\_circuit\_id) | The ID of the Express Route Circuit when creating an ExpressRoute connection | `string` | `null` | no |
| <a name="input_local_networks"></a> [local\_networks](#input\_local\_networks) | List of local virtual network connections to connect to gateway. | <pre>object({<br>    name            = string,<br>    gateway_address = string,<br>    address_space   = list(string)<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The override name for the resource | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_shared_key"></a> [shared\_key](#input\_shared\_key) | The key to access to connect to gateways. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of connection. Valid options are IPsec, ExpressRoute or Vnet2Vnet. | `string` | `"IPsec"` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | Resource ID of the VPN Gateway | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | Network Gateway Connection Ids |
| <a name="output_names"></a> [names](#output\_names) | Network Gateway Connections |
<!-- END_TF_DOCS -->