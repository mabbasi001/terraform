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
| [azurerm_storage_management_policy.sa_diagnostic_retention_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blob_types"></a> [blob\_types](#input\_blob\_types) | List of blob types, expects; appendBlob, blockBlob - defaults to appendBlob | `list(string)` | <pre>[<br>  "appendBlob"<br>]</pre> | no |
| <a name="input_container_filter_prefix"></a> [container\_filter\_prefix](#input\_container\_filter\_prefix) | The prefix of blobs to filter. | `list(string)` | `null` | no |
| <a name="input_delete_blobs_after_creation_time_in_days"></a> [delete\_blobs\_after\_creation\_time\_in\_days](#input\_delete\_blobs\_after\_creation\_time\_in\_days) | Number of days since creation after which blobs are deleted - defaults to -1 (off). | `number` | `-1` | no |
| <a name="input_delete_blobs_after_last modified_in_days"></a> [delete\_blobs\_after\_last modified\_in\_days](#input\_delete\_blobs\_after\_last modified\_in\_days) | Number of days since modification after which blobs are deleted - defaults to 7. | `number` | `7` | no |
| <a name="input_delete_blobs_after_last_access_time_in_days"></a> [delete\_blobs\_after\_last\_access\_time\_in\_days](#input\_delete\_blobs\_after\_last\_access\_time\_in\_days) | Number of days since last access after which blobs are deleted - defaults to -1 (off). | `number` | `-1` | no |
| <a name="input_delete_snapshot_after_creation_time_in_days"></a> [delete\_snapshot\_after\_creation\_time\_in\_days](#input\_delete\_snapshot\_after\_creation\_time\_in\_days) | Number of days since creation after which snapshots are deleted - defaults to -1 (off). | `number` | `-1` | no |
| <a name="input_delete_version_after_creation_time_in_days"></a> [delete\_version\_after\_creation\_time\_in\_days](#input\_delete\_version\_after\_creation\_time\_in\_days) | Number of days since creation after which version are deleted - defaults to -1 (off). | `number` | `-1` | no |
| <a name="input_name"></a> [name](#input\_name) | The override name for the resource. | `string` | `null` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | The suffix to be appended to the auto-generated name of the resource. | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The id of the storage account. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->