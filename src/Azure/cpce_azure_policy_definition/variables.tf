variable "name" {
  description = "The name of the Policy Assignment."
  type        = string
}

variable "policy_type" {
  description = "The policy type. Possible values are BuiltIn, Custom and NotSpecified. Changing this forces a new resource to be created."
  type        = string
}

variable "mode" {
  description = "The policy mode that allows you to specify which resource types will be evaluated."
  type        = string
}

variable "display_name" {
  description = "The display name of the policy definition."
  type        = string
}

variable "description" {
  description = "The description of the policy definition."
  type        = string
  default     = null
}

variable "management_group_id" {
  description = "The id of the Management Group where this policy should be defined. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "policy_rule" {
  description = "The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block."
  type        = string
  default     = null
}

variable "metadata" {
  description = "The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition."
  type        = string
  default     = null
}

variable "parameters" {
  description = "Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition."
  type        = string
  default     = null
}
