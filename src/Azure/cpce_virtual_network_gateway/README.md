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
| [azurerm_virtual_network_gateway.vnet_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for to which this resource belongs. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | The code of the environment in which this resource should exist. | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | Details of the IP configuration of the Virtual Network Gateway (within its Virtual Network). | <pre>object({<br>    name                               = string<br>    subnet_id                          = string<br>    private_ip_address_allocation_type = string<br>    public_ip_address_id               = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The region in which this resource should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | An override for the name of this resource. If supplied, customer\_code, environment\_code & name\_suffix will be ignored. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create this resource. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Configuration of the size and capacity of the virtual network gateway. Valid options are 'ErGw1AZ', 'ErGw2AZ', 'ErGw3AZ', 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw4', 'VpnGw5', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3AZ', 'VpnGw4AZ' & 'VpnGw5AZ' and also depend on the type, vpn\_type and generation arguments. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway. | `string` | `"VpnGw1AZ"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the Virtual Network Gateway. Possible values are 'Vpn' or 'ExpressRoute'. Default's to 'Vpn'. | `string` | `"Vpn"` | no |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | The routing type of the Virtual Network Gateway. Valid options are 'RouteBased' or 'PolicyBased'. Defaults to 'RouteBased'. | `string` | `"RouteBased"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Resource ID of the Virtual Network Gateway resource. |
| <a name="output_name"></a> [name](#output\_name) | Name of the Virtual Network Gateway resource. |
<!-- END_TF_DOCS -->