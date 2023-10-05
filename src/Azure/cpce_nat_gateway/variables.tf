variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
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

variable "name" {
  description = "The override name for the resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

variable "sku_name" {
  description = "(Optional) The SKU of the Azure NAT Gateway.At this time the only supported value is Standard."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.sku_name)
    error_message = "Allowed values for Azure NAT Gateway \"Standard\"."
  }
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) The idle timeout which should be used in minutes. Defaults to 4"
  type        = number
  default     = 4
}

variable "public_ip_addresses" {
  description = "List of public ips to use. "
  type        = list(string)
  default     = []
}
variable "subnet_ids" {
  description = "Ids of subnets to associate with the Nat Gateway"
  type        = list(string)
  default     = []
}
