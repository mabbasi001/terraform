<!-- BEGIN_TF_DOCS -->
# Terraform B2C Module Documentation

This documentation provides details about the Terraform module for creating an Azure Active Directory B2C.
Azure Active Directory B2C provides business-to-customer identity as a service.

## Usage

## Requirements

Make sure you have the following prerequisites:

- Terraform CLI installed
- Azure CLI installed
- Azure subscription and credentials configured (user account to interact with UI)
- Directory Creation role or higher
-

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_http-full"></a> [http-full](#requirement\_http-full) | =1.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_aadb2c_directory.aadb2c](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/aadb2c_directory) | resource |
| [azurerm_resource_group.b2c_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_account_name"></a> [az\_account\_name](#input\_az\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_b2c_data_residency_location"></a> [b2c\_data\_residency\_location](#input\_b2c\_data\_residency\_location) | B2C location | `string` | `"Europe"` | no |
| <a name="input_b2c_display_name"></a> [b2c\_display\_name](#input\_b2c\_display\_name) | Azure AD B2C display name | `any` | n/a | yes |
| <a name="input_b2c_domain_name"></a> [b2c\_domain\_name](#input\_b2c\_domain\_name) | Azure AD B2C domain name | `string` | `"onmicrosoft.com"` | no |
| <a name="input_b2c_region"></a> [b2c\_region](#input\_b2c\_region) | B2C country code | `string` | `"GB"` | no |
| <a name="input_b2c_sku"></a> [b2c\_sku](#input\_b2c\_sku) | Sku type for Azure AD B2C | `string` | `"PremiumP2"` | no |
| <a name="input_cert_name"></a> [cert\_name](#input\_cert\_name) | The name for the cert | `string` | `"b2ccet"` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_dns_names"></a> [dns\_names](#input\_dns\_names) | DNS alternative names | `list` | <pre>[<br>  "cpcelimited.com",<br>  "cpce.com"<br>]</pre> | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_environment_rg_name"></a> [environment\_rg\_name](#input\_environment\_rg\_name) | Resource Group name used by the environment | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Key Vault id | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The Name which should be used for this resource it will override the concatenated one | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_policy_keys"></a> [policy\_keys](#input\_policy\_keys) | List of Certs to be created for B2C | <pre>map(object({<br>    name = string<br>  }))</pre> | <pre>{<br>  "global": {<br>    "name": "TSKC"<br>  },<br>  "userflow": {<br>    "name": "UF"<br>  }<br>}</pre> | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of service that cert will be used | `string` | `"b2c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azcli_account_name"></a> [azcli\_account\_name](#output\_azcli\_account\_name) | The name of the Azure CLI account used for authentication. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The custom domain name associated with the Azure AD B2C tenant. |
| <a name="output_id"></a> [id](#output\_id) | The resource ID of the Azure AD B2C tenant. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name created with the B2C resource. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | provide me a short description for azurerm\_aadb2c\_directory.aadb2c.tenant\_id to use in terraform output |
<!-- END_TF_DOCS -->