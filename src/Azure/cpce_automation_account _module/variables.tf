variable "resource_group_name" {
  description = "The name of the resource group this resource will be put"
  type        = string
}

variable "name" {
  description = "Name of the module"
  type        = string
}

variable "automation_account_name" {
  description = "The automation account which will use the modules"
  type        = string
}

variable "content_link" {
  description = "Link to consume module"
  type        = string
}

