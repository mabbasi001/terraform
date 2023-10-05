<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | 2.0.0-preview3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 2.0.0-preview3 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.name](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview3/docs/resources/name) | resource |
| [azurerm_container_group.cpce_container_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_password"></a> [acr\_password](#input\_acr\_password) | Password for Azure Container Registry | `string` | n/a | yes |
| <a name="input_acr_server"></a> [acr\_server](#input\_acr\_server) | Hostname of Azure Container Registry instance | `string` | n/a | yes |
| <a name="input_acr_username"></a> [acr\_username](#input\_acr\_username) | Username for Azure Container Registry | `string` | n/a | yes |
| <a name="input_build_agents"></a> [build\_agents](#input\_build\_agents) | Definition of the build agents to host in the Azure Container Instances | <pre>list(object({<br>    name                         = string<br>    image                        = string<br>    cpu                          = number<br>    memory                       = number<br>    environment_variables        = map(string)<br>    secure_environment_variables = map(string)<br>    port                         = number<br>  }))</pre> | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The base name for the resource | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Name of the resource group where container group should be provisioned | `string` | n/a | yes |
| <a name="input_restart_policy"></a> [restart\_policy](#input\_restart\_policy) | n/a | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | An Id of subnet where containers should be provisioned | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->