terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.36.0"
    }
  }
}
