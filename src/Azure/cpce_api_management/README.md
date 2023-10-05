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
| [azurerm_api_management.cpce_apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_location"></a> [additional\_location](#input\_additional\_location) | List of the name of the Azure Region in which the API Management Service should be expanded to. | <pre>map(object({<br>    location             = string<br>    zones                = list(number)<br>    capacity             = string<br>    public_ip_address_id = string<br>    subnet_id            = string<br>  }))</pre> | `{}` | no |
| <a name="input_certificate_configuration"></a> [certificate\_configuration](#input\_certificate\_configuration) | List of certificate configurations | `list(map(string))` | `[]` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | (Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`. | `bool` | `false` | no |
| <a name="input_customer_code"></a> [customer\_code](#input\_customer\_code) | The code of the customer for which this resource was created | `string` | `null` | no |
| <a name="input_developer_portal_hostname_configuration"></a> [developer\_portal\_hostname\_configuration](#input\_developer\_portal\_hostname\_configuration) | Developer portal hostname configurations | `list(map(string))` | `[]` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Should HTTP/2 be supported by the API Management Service? | `bool` | `false` | no |
| <a name="input_enable_sign_in"></a> [enable\_sign\_in](#input\_enable\_sign\_in) | Should anonymous users be redirected to the sign in page? | `bool` | `false` | no |
| <a name="input_enable_sign_up"></a> [enable\_sign\_up](#input\_enable\_sign\_up) | Can users sign up on the development portal? | `bool` | `false` | no |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT') | `string` | `null` | no |
| <a name="input_gateway_disabled"></a> [gateway\_disabled](#input\_gateway\_disabled) | (Optional) Disable the gateway in main region? This is only supported when `additional_location` is set. | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Type of Managed Service Identity that should be configured on this API Management Service | `string` | `"SystemAssigned"` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist. | `string` | n/a | yes |
| <a name="input_management_hostname_configuration"></a> [management\_hostname\_configuration](#input\_management\_hostname\_configuration) | List of management hostname configurations | `list(map(string))` | `[]` | no |
| <a name="input_min_api_version"></a> [min\_api\_version](#input\_min\_api\_version) | (Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the apim resource. If provided, this will override the auto-generated name. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of both the resource and host | `string` | `null` | no |
| <a name="input_notification_sender_email"></a> [notification\_sender\_email](#input\_notification\_sender\_email) | Email address from which the notification will be sent | `string` | `null` | no |
| <a name="input_policy_configuration"></a> [policy\_configuration](#input\_policy\_configuration) | Map of policy configuration | `map(string)` | `{}` | no |
| <a name="input_portal_hostname_configuration"></a> [portal\_hostname\_configuration](#input\_portal\_hostname\_configuration) | Legacy portal hostname configurations | `list(map(string))` | `[]` | no |
| <a name="input_proxy_hostname_configuration"></a> [proxy\_hostname\_configuration](#input\_proxy\_hostname\_configuration) | List of proxy hostname configurations | `list(map(string))` | `[]` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | public ip address id needed if apim is external | `string` | `null` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email of publisher/company. | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of publisher/company. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which this virtual machine should exist. | `string` | n/a | yes |
| <a name="input_scm_hostname_configuration"></a> [scm\_hostname\_configuration](#input\_scm\_hostname\_configuration) | List of scm hostname configurations | `list(map(string))` | `[]` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | Map of security configuration | `map(string)` | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity | `string` | `"Basic_1"` | no |
| <a name="input_terms_of_service_configuration"></a> [terms\_of\_service\_configuration](#input\_terms\_of\_service\_configuration) | Map of terms of service configuration | `list(map(string))` | <pre>[<br>  {<br>    "consent_required": false,<br>    "enabled": false,<br>    "text": ""<br>  }<br>]</pre> | no |
| <a name="input_virtual_network_configuration"></a> [virtual\_network\_configuration](#input\_virtual\_network\_configuration) | The id(s) of the subnet(s) that will be used for the API Management. Required when virtual\_network\_type is External or Internal | `list(string)` | `[]` | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The type of virtual network you want to use, valid values include: None, External, Internal. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier. | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_location"></a> [additional\_location](#output\_additional\_location) | additional hosted locations of the azure api management. |
| <a name="output_developer_portal_url"></a> [developer\_portal\_url](#output\_developer\_portal\_url) | The developer portal url of the azure api management. |
| <a name="output_gateway_regional_url"></a> [gateway\_regional\_url](#output\_gateway\_regional\_url) | The gateway url of the azure api management. |
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The gateway url of the azure api management. |
| <a name="output_id"></a> [id](#output\_id) | The resource ID of the azure api management. |
| <a name="output_management_api_url"></a> [management\_api\_url](#output\_management\_api\_url) | The management api url of the azure api management. |
| <a name="output_name"></a> [name](#output\_name) | The resource name of the azure api management. |
| <a name="output_portal_url"></a> [portal\_url](#output\_portal\_url) | The portal url of the azure api management. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The private ip addresses of the azure api management. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | The public ip addresses of the azure api management. |
| <a name="output_scm_url"></a> [scm\_url](#output\_scm\_url) | The SCM (Source Code Management) Endpoint associated with the azure api management. |
<!-- END_TF_DOCS -->