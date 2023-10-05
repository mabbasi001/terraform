# Description

Terraform modules by CPCE Platform for use by CPCE teams.

**NB** AzureRM provider version is pinned within some modules to v2.95 due to an issue with the DSC VM extension and changes to the supported version of the ARM API in versions higher than 2.96. More info at: [Terraform Github Issue 10858](https://github.com/hashicorp/terraform-provider-azurerm/issues/10858)

---

## Process for Updating this Repository

1. Create a new branch off of the main branch
2. Add changes for your feature/bugfix
3. Make a pull request back into main
4. Have at **least** one other person review your changes
5. Resolve and push any changes that need to be made then repeat step 4
6. Once your changes have been reviewed and approved, you can merge your changes back into main

---

## Versioning for this Repository

This repo uses git tagging as the chosen versioning tool. A tag is automatically incremented and applied after every merge. Versioning follows `major.minor.patch` with the `major.minor` being set freely by the owners of the product/repo. For more information about our [Git Tag Versioning Template](https://dev.azure.com/cpce-limited/Platform/_git/pipeline-templates?path=/src/version-template/README.md&_a=preview)

---

## Terraform Module Changes

### **azurerm provider version update:** 2.95.0 -> 3.65.0

- Module: `cpce_active_directory_domain_services`
-       New argument: domain_configuration_type
        Type: string
        Default Value: "FullySynced"
-       New argument: kerberos_rc4_encryption_enabled
        Type: bool
        Default: False
- Module: `cpce_azure_policy_definition`
-       Change Argument: management_group_name -> management_group_id
        Type: string -> string
        Default: null -> null
- Module: `cpce_load_balancer`
-       Change argument: availability_zone -> zones
        Type: string -> list(string)
        Default: "Zone-Redundant" -> [ "1", "2", "3" ]
- Module: `cpce_mssql_server`
-       Change argument: user_assigned_identity_ids -> identity_ids
        Type: list(string) -> list(string)
        Default: null -> null
- Module: `cpce_public_ip_address`
-       Change argument: availability_zone -> zones
        Type: string -> list(string)
        Default: "Zone-Redundant" -> [ "1", "2", "3" ]
- Module: `cpce_storage_account`
-       Change argument: allow_blob_public_access -> allow_nested_items_to_be_public
        Type: bool -> bool
        Default: false -> false
- Change Module: `cpce_azure_policy_assignment -> Replaced by Following`
-       New Module: cpce_azure_management_group_policy_assignment
        New Module: cpce_azure_resource_group_policy_assignment
        New Module: cpce_azure_resource_policy_assignment
        New Module: cpce_azure_subscription_policy_assignment
