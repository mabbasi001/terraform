terraform {
  backend "local" {
    #  use_azuread_auth = true
  }
  required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "= 3.75.0"
        }
    }
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
provider "azuread" {}