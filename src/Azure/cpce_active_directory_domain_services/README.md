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
| [azurerm_active_directory_domain_service.aadds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/active_directory_domain_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_configuration_type"></a> [domain\_configuration\_type](#input\_domain\_configuration\_type) | The configuration type of this Active Directory Domain. | `string` | `"FullySynced"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The Active Directory domain to be created in the Virtual Network.<br>See https://docs.microsoft.com/en-gb/azure/active-directory-domain-services/tutorial-create-instance#create-a-managed-domain for constraints and recommendations. | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'TEST' or 'PROD'). Changing this forces the resource to be destroyed/recreated. | `string` | `null` | no |
| <a name="input_filtered_sync_enabled"></a> [filtered\_sync\_enabled](#input\_filtered\_sync\_enabled) | Should filtered synchronisation be enabled? If enable, the specific groups to syncrhonise needs to be managed outside of Terraform. | `bool` | `false` | no |
| <a name="input_instance_code"></a> [instance\_code](#input\_instance\_code) | A code for the instance of the front door that is being created (e.g. 'CPCE' or 'MS'). Changing this forces the resource to be destroyed/recreated. | `string` | `null` | no |
| <a name="input_kerberos_rc4_encryption_enabled"></a> [kerberos\_rc4\_encryption\_enabled](#input\_kerberos\_rc4\_encryption\_enabled) | Whether to enable Kerberos RC4 Encryption. | `bool` | `true` | no |
| <a name="input_ldaps_certificate"></a> [ldaps\_certificate](#input\_ldaps\_certificate) | The base64-encoded TripleDES-SHA1 encrypted PKCS#12 representation of the certificate used for secure LDAPS. | `string` | n/a | yes |
| <a name="input_ldaps_certificate_password"></a> [ldaps\_certificate\_password](#input\_ldaps\_certificate\_password) | The password of the certificate used for secure LDAPS. | `string` | n/a | yes |
| <a name="input_ldaps_enable"></a> [ldaps\_enable](#input\_ldaps\_enable) | Whether to enable secure LDAP for the managed domain. | `bool` | `true` | no |
| <a name="input_ldaps_external_access_enabled"></a> [ldaps\_external\_access\_enabled](#input\_ldaps\_external\_access\_enabled) | Whether to enable secure LDAP for external access. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which the AADDS resource should be created. Changing this forces the resource to be destroyed/recreated. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource. Changing this forces the resource to be destroyed/recreated. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource. Changing this forces the resource to be destroyed/recreated. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Azure front door. Changing this forces the resource to be destroyed/recreated. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for this AADDS instance. Possible values are 'Standard', 'Enterprise' & 'Premium'. | `string` | `"Enterprise"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Resource ID of the subnet into which the primary domain controller replica set will be deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure AD Domain Service. |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_replica_set"></a> [primary\_replica\_set](#output\_primary\_replica\_set) | Details of the replica set containing the primary domain controllers. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource ID of the Azure AD Domain Service. |
<!-- END_TF_DOCS -->