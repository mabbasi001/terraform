variable "name" {
  description = "The name of the Policy Assignment."
  type        = string
}

variable "location" {
  description = "The Azure location where this policy assignment should exist. This is required when an Identity is SystemAssigned."
  type        = string
}

variable "policy_definition_id" {
  description = "The ID of the Policy Definition to be applied at the specified Scope."
  type        = string
}

variable "subscription_id" {
  description = "The ID of the Subscription where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created."
  type        = string
}

variable "description" {
  description = "A description to use for this Policy Assignment. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A friendly display name to use for this Policy Assignment. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "identity_type" {
  description = "The Managed Service Identity Type of this Policy Assignment. Possible values are SystemAssigned (where Azure will generate a Service Principal for you), or None (no use of a Managed Service Identity)."
  type        = string
  default     = "None"
}
