<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | ~>1.2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | ~>1.2.23 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.azurerm_application_insights_web_test](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.azurerm_monitor_action_group](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.azurerm_monitor_metric_alert](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_application_insights_web_test.cpce_application_insights_web_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_web_test) | resource |
| [azurerm_monitor_action_group.cpce_monitor_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_metric_alert.cpce_monitor_metric_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_group_id"></a> [action\_group\_id](#input\_action\_group\_id) | The id of the action group to be used. If set overrides use of alert\_emails | `string` | `null` | no |
| <a name="input_alert_description"></a> [alert\_description](#input\_alert\_description) | The description to be shown to alerted users when the web test fails | `string` | `""` | no |
| <a name="input_alert_emails"></a> [alert\_emails](#input\_alert\_emails) | The emails of users that should be informed when the web test fails. If no emails are set, the alert will not be created. If action\_group\_id provided then is not used | `set(string)` | `[]` | no |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | The id of the Application Insights resource associated to this web test | `string` | n/a | yes |
| <a name="input_environment_code"></a> [environment\_code](#input\_environment\_code) | A code for the environment in which the resource is being created (e.g. "BVT" or "UAT") | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The datacentre in which the resource should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name for the resource | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource | `string` | `null` | no |
| <a name="input_reference_action_group"></a> [reference\_action\_group](#input\_reference\_action\_group) | Boolean to state that action group id will be referenced | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group this resource will be put | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags that should be assigned to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_location"></a> [target\_location](#input\_target\_location) | The location of the target resource under test - for use in differentiating tests in the same app insights | `string` | `null` | no |
| <a name="input_web_test_configuration"></a> [web\_test\_configuration](#input\_web\_test\_configuration) | An XML configuration specification for a web test | `string` | n/a | yes |
| <a name="input_web_test_geo_locations"></a> [web\_test\_geo\_locations](#input\_web\_test\_geo\_locations) | The geographical locations that should be used to perform the web test | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_test_id"></a> [web\_test\_id](#output\_web\_test\_id) | n/a |
<!-- END_TF_DOCS -->