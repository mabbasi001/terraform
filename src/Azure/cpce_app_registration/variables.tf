variable "api_permissions" {
  description = "api permissions to be declared from the application"
  type = map(object({
    application_id = optional(string, null)
    is_managed_resource = optional(bool, false)
    managed_resource_application_id = optional(string, null)
    managed_resource_serviceprincipal_object_id = optional(string, null)
    resource_access = map(object({
      type = string
      managed_resource_resource_access_id = optional(string, null)
    }))
  }))
  default = {}
}

variable "redirect_uris" {
  description = "redirect_uris, spa, web or public_client"
  type        = map(map(string))
  default     = {}
}

variable "implicit_grant" {
  description = "implicit_grant, allowed values are access_token or id_token"
  type        = list(string)
  default     = []
}

variable "optional_claims" {
  description = "optional claims, e.g.: preferred_username"
  type        = map(list(string))
  default     = {}
}

variable "app_roles" {
  description = "app roles to be exposed from the application"
  type = map(object({
    uid                  = string,
    description          = string,
    allowed_member_types = string
  }))
  default = {}
}

variable "scopes" {
  description = "scopes to be exposed from the application"
  type = map(object({
    uid         = string,
    description = string,
    type        = string
  }))
  default = {}
}

variable "application_name" {
  description = "application name"
  type        = string
}

variable "domain" {
  description = "AAD domain"
  type        = string
}

variable "environment_code" {
  description = "Short name of the environment we are deploying to"
  type        = string
  default     = ""
}

variable "branch_name" {
  description = "Name of the source branch"
  type        = string
  default     = ""
}

variable "configuration_name" {
  description = "Name of configuration which we are deploying"
  type        = string
  default     = ""
}

variable "environment_quality" {
  description = "The quality of the environment we are deploying to, consent will be granted if value = DEV"
  type        = string
  default     = null
}

variable "grant_admin_consent" {
  description = "When set to true automatically grant admin consent"
  type        = bool
  default     = true
}

variable "is_public_client" {
  description = "Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI."
  type        = bool
  default     = false
}

variable "secret_expiry_date" {
  description = "secret expiry date, string wrapped by single quote"
  type        = string
  default     = null
}

variable "secret_required" {
  description = "set to true if secret is required"
  type        = bool
  default     = true
}

variable "unique_suffix" {
  description = "unique suffix to distinguish between customers in the same tenant"
  type        = string
  default     = ""
}

variable "sign_in_audience" {
  description = "The Microsoft account types that are supported for the current application. Must be one of \"AzureADMyOrg\", \"AzureADMultipleOrgs\", \"AzureADandPersonalMicrosoftAccount\" or \"PersonalMicrosoftAccount\". Defaults to \"AzureADMyOrg\"."
  type        = string
  default     = "AzureADMyOrg"
  validation {
    condition     = contains(["AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount"], var.sign_in_audience)
    error_message = "Allowed values for sign_in_audience are \"AzureADMyOrg\", \"AzureADMultipleOrgs\", \"AzureADandPersonalMicrosoftAccount\", or \"PersonalMicrosoftAccount\"."
  }
}
