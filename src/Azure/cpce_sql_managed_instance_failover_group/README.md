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
| [azurerm_sql_managed_instance_failover_group.cpce_sql_mi_failover_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_managed_instance_failover_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_endpoint_failover_policy_auto_grace_minutes"></a> [endpoint\_failover\_policy\_auto\_grace\_minutes](#input\_endpoint\_failover\_policy\_auto\_grace\_minutes) | Applies only if mode is Automatic. The grace period in minutes before failover with data loss is attempted. | `number` | `60` | no |
| <a name="input_endpoint_failover_policy_mode"></a> [endpoint\_failover\_policy\_mode](#input\_endpoint\_failover\_policy\_mode) | The failover mode. | `string` | `"Automatic"` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_managed_instance_name"></a> [managed\_instance\_name](#input\_managed\_instance\_name) | The name of the Azure SQL Managed Instance which will be replicated using a Managed Instance Failover Group. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure SQL Managed Instance Failover resource. If provided, this will override the auto-generated name. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of both the resource and host | `string` | `null` | no |
| <a name="input_partner_managed_instance_id"></a> [partner\_managed\_instance\_id](#input\_partner\_managed\_instance\_id) | The ID of the Azure SQL Managed Instance which will be replicated to. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this resource should exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the failover group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the failover group. |
| <a name="output_partner_region"></a> [partner\_region](#output\_partner\_region) | Location and Role of the partner region where partner region exists. |
<!-- END_TF_DOCS -->