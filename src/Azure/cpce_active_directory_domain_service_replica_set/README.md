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
| [azurerm_active_directory_domain_service_replica_set.replica_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/active_directory_domain_service_replica_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_active_directory_domain_service"></a> [azure\_active\_directory\_domain\_service](#input\_azure\_active\_directory\_domain\_service) | The ID of the Azure Active Directory Domain Service resource to which this replica set belongs. | <pre>object({<br>    id                             = string<br>    domain_controller_ip_addresses = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | A code representing the customer for which this Hub is being provisioned. Changing this forces the resource to be destroyed/recreated. | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'TEST' or 'PROD'). Changing this forces the resource to be destroyed/recreated. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which the AADDS replica set should be created. | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to all the AADDS replica resources to make their names unique within the Resource Group. | `string` | `"aaddsreplica01"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet to associate the replica set to. | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the virtual network to which the replica set is to be associated. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_controller_ip_addresses"></a> [domain\_controller\_ip\_addresses](#output\_domain\_controller\_ip\_addresses) | A list of the IP addresses for the domain controllers (typically two). |
| <a name="output_external_access_ip_address"></a> [external\_access\_ip\_address](#output\_external\_access\_ip\_address) | The publicly routable IP address for the domain controllers in this Replica Set. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Active Directory Domain Service Replica Set. |
<!-- END_TF_DOCS -->