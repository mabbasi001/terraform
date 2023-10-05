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
| [azurerm_firewall.cpce_firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created. | `string` | `null` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT"). | `string` | `null` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | route table to configure routes | <pre>object({<br>    name               = string<br>    sku_name           = string<br>    sku_tier           = string<br>    firewall_policy_id = string<br>  })</pre> | n/a | yes |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | route table to configure routes | <pre>object({<br>    name                 = string<br>    subnet_id            = string<br>    public_ip_address_id = string<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which application gateway to be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Firewall Id |
| <a name="output_ip"></a> [ip](#output\_ip) | Firewall private ip address |
<!-- END_TF_DOCS -->