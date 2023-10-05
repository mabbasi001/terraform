#=====================================================
# Define the input variables for the Terraform module.
#=====================================================
# These variables provide information for Azure AD B2C.
variable "b2c_display_name" {
  description = "Azure AD B2C display name"
}
variable "b2c_domain_name" {
  description = "Azure AD B2C domain name"
  default = "onmicrosoft.com"
}
variable "b2c_data_residency_location" {
  description = "B2C location"
  default = "Europe"
}
variable "b2c_region" {
  description = "B2C country code"
  default = "GB"
}
variable "b2c_sku" {
  description = "Sku type for Azure AD B2C"
  default = "PremiumP2"
}
variable "name" {
  description = "The Name which should be used for this resource it will override the concatenated one"
  type        = string
  default     = null
}
variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}
variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource"
  type        = string
  default     = null
}
variable "location" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}
variable "key_vault_id" {
  description = "Key Vault id"
}
variable "dns_names" {
  description = "DNS alternative names"
  default     = ["cpcelimited.com", "cpce.com"]
}
variable "service_name" {
  description = "The name of service that cert will be used"
  default = "b2c"
}
variable "cert_name" {
  description = "The name for the cert"
  default = "b2ccet"
}
variable "policy_keys" {
  description = "List of Certs to be created for B2C"
  type = map(object({
    name = string
  }))
  default = {
    "global"= {
        name = "TSKC"
      }
    "userflow" = {
      name = "UF"
    }
  }
}
variable "environment_rg_name" {
  description = "Resource Group name used by the environment"
  type = string
}

variable "az_account_name" {
  description = ""
  type = string
}