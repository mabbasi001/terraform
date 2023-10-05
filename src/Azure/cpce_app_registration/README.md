<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | =2.38.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | =2.38.0 |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.application_calling_downstream_apis](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.application_calling_downstream_apis_managed_resource](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/app_role_assignment) | resource |
| [azuread_application.application](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/application) | resource |
| [azuread_application_password.application](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/application_password) | resource |
| [azuread_service_principal.application](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/service_principal) | resource |
| [azuread_service_principal_delegated_permission_grant.application_calling_downstream_apis](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/service_principal_delegated_permission_grant) | resource |
| [azuread_service_principal_delegated_permission_grant.application_calling_downstream_apis_managed_resource](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/resources/service_principal_delegated_permission_grant) | resource |
| [time_offset.two_years](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/client_config) | data source |
| [azuread_service_principal.down_stream_apis](https://registry.terraform.io/providers/hashicorp/azuread/2.38.0/docs/data-sources/service_principal) | data source |
| [external_external.existing_apis](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_permissions"></a> [api\_permissions](#input\_api\_permissions) | api permissions to be declared from the application | <pre>map(object({<br>    application_id = optional(string, null)<br>    is_managed_resource = optional(bool, false)<br>    managed_resource_application_id = optional(string, null)<br>    managed_resource_serviceprincipal_object_id = optional(string, null)<br>    resource_access = map(object({<br>      type = string<br>      managed_resource_resource_access_id = optional(string, null)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_app_roles"></a> [app\_roles](#input\_app\_roles) | app roles to be exposed from the application | <pre>map(object({<br>    uid                  = string,<br>    description          = string,<br>    allowed_member_types = string<br>  }))</pre> | `{}` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | application name | `string` | n/a | yes |
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Name of the source branch | `string` | `""` | no |
| <a name="input_configuration_name"></a> [configuration\_name](#input\_configuration\_name) | Name of configuration which we are deploying | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | AAD domain | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | Short name of the environment we are deploying to | `string` | `""` | no |
| <a name="input_environment_quality"></a> [environment\_quality](#input\_environment\_quality) | The quality of the environment we are deploying to, consent will be granted if value = DEV | `string` | `null` | no |
| <a name="input_grant_admin_consent"></a> [grant\_admin\_consent](#input\_grant\_admin\_consent) | When set to true automatically grant admin consent | `bool` | `true` | no |
| <a name="input_implicit_grant"></a> [implicit\_grant](#input\_implicit\_grant) | implicit\_grant, allowed values are access\_token or id\_token | `list(string)` | `[]` | no |
| <a name="input_is_public_client"></a> [is\_public\_client](#input\_is\_public\_client) | Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI. | `bool` | `false` | no |
| <a name="input_optional_claims"></a> [optional\_claims](#input\_optional\_claims) | optional claims, e.g.: preferred\_username | `map(list(string))` | `{}` | no |
| <a name="input_redirect_uris"></a> [redirect\_uris](#input\_redirect\_uris) | redirect\_uris, spa, web or public\_client | `map(map(string))` | `{}` | no |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | scopes to be exposed from the application | <pre>map(object({<br>    uid         = string,<br>    description = string,<br>    type        = string<br>  }))</pre> | `{}` | no |
| <a name="input_secret_expiry_date"></a> [secret\_expiry\_date](#input\_secret\_expiry\_date) | secret expiry date, string wrapped by single quote | `string` | `null` | no |
| <a name="input_secret_required"></a> [secret\_required](#input\_secret\_required) | set to true if secret is required | `bool` | `true` | no |
| <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience) | The Microsoft account types that are supported for the current application. Must be one of "AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount" or "PersonalMicrosoftAccount". Defaults to "AzureADMyOrg". | `string` | `"AzureADMyOrg"` | no |
| <a name="input_unique_suffix"></a> [unique\_suffix](#input\_unique\_suffix) | unique suffix to distinguish between customers in the same tenant | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id_uri"></a> [app\_id\_uri](#output\_app\_id\_uri) | app id uri |
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | app\_role\_ids passthrough from resource azuread\_application |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client Id |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Client Secret |
| <a name="output_client_secret_name"></a> [client\_secret\_name](#output\_client\_secret\_name) | client secret name |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | display name of AzureAD app reg |
| <a name="output_down_stream_apis"></a> [down\_stream\_apis](#output\_down\_stream\_apis) | application\_id and app\_id\_uri for downstream apis |
| <a name="output_service_principal_object_id"></a> [service\_principal\_object\_id](#output\_service\_principal\_object\_id) | Service Principal Object Id |
<!-- END_TF_DOCS -->