<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_shared_key"></a> [shared\_key](#module\_shared\_key) | ../../Random/cpce_random_password | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_local_network_gateway.onprem_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.vpn_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_protocol"></a> [connection\_protocol](#input\_connection\_protocol) | The IKE protocol version to use. Possible values are 'IKEv1' and 'IKEv2'. | `string` | `"IKEv2"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_dpd_timeout_seconds"></a> [dpd\_timeout\_seconds](#input\_dpd\_timeout\_seconds) | The dead peer detection timeout of this connection in seconds. | `number` | `45` | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | Whether Border Gateway Protocol is enabled for this VPN connection. | `string` | `false` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | The code of the environment in which this VNET Gateway Connection should exist. | `string` | `null` | no |
| <a name="input_express_route_authorization_key"></a> [express\_route\_authorization\_key](#input\_express\_route\_authorization\_key) | The authorization key associated with the Express Route Circuit. | `string` | `null` | no |
| <a name="input_express_route_circuit_id"></a> [express\_route\_circuit\_id](#input\_express\_route\_circuit\_id) | The ID of the Express Route Circuit when creating an ExpressRoute connection | `string` | `null` | no |
| <a name="input_ipsec_policy"></a> [ipsec\_policy](#input\_ipsec\_policy) | The policy to apply to the IPSec connection | <pre>object({<br>    dh_group         = string<br>    ike_encryption   = string<br>    ike_integrity    = string<br>    ipsec_encryption = string<br>    ipsec_integrity  = string<br>    pfs_group        = string<br>    sa_datasize      = number<br>    sa_lifetime      = number<br>  })</pre> | `null` | no |
| <a name="input_local_network_gateway_name"></a> [local\_network\_gateway\_name](#input\_local\_network\_gateway\_name) | An override name for the name of the Local Network Gateway resource. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The region in which the resource should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | An override for the name of the Virtual Network Gateway Connection resource. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_peer_virtual_network_gateway_id"></a> [peer\_virtual\_network\_gateway\_id](#input\_peer\_virtual\_network\_gateway\_id) | The ID of the peer virtual network gateway when creating a VNet-to-VNet connection. | `string` | `null` | no |
| <a name="input_remote_network_address_space"></a> [remote\_network\_address\_space](#input\_remote\_network\_address\_space) | The address ranges of the remote network to be exposed by this Connection (in CIDR format). | `list(string)` | `null` | no |
| <a name="input_remote_network_gateway_ip_address"></a> [remote\_network\_gateway\_ip\_address](#input\_remote\_network\_gateway\_ip\_address) | IP address of the gateway in the remote network to which this connection is being made. | `string` | `null` | no |
| <a name="input_remote_network_gateway_shared_key"></a> [remote\_network\_gateway\_shared\_key](#input\_remote\_network\_gateway\_shared\_key) | The pre-shared key to be used for encrypting traffic over the VPN connection. If not supplied, one will be generated. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of connection to be created. Valid options are 'IPsec' or 'ExpressRoute'. | `string` | `"IPsec"` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | Resource ID of the Virtual Network Gateway resource in which to create this connection. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Resource ID of the Virtual Network Gateway Connection resource. |
| <a name="output_local_network_gateway_id"></a> [local\_network\_gateway\_id](#output\_local\_network\_gateway\_id) | Resource ID of the Local Network Gateway resource |
| <a name="output_name"></a> [name](#output\_name) | Name of the Virtual Network Gateway Connection resource. |
| <a name="output_shared_key"></a> [shared\_key](#output\_shared\_key) | Shared key of the Virtual Network Gateway Connection. |
<!-- END_TF_DOCS -->