variable "resource_group_name" {
  description = "The name of the resource group in which this resource should exist."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created"
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'BVT' or 'UAT')"
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of both the resource and host"
  type        = string
  default     = null
  validation {
    # This is a maximum of 9 characters because it will be used to generate the host name, which has a maximum of 15 characters. 6 will have been used by the customer and environment codes, leaving 9 available here.
    # The allowed character set is slightly more restrictive than Azure allows. See https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftcompute
    condition     = (var.name_suffix == null ? true : can(regex("^([a-zA-Z0-9])([a-zA-Z0-9\\-]{1,7})([A-Za-z0-9])$", var.name_suffix)))
    error_message = "Invalid name_suffix. Using this value would result in the generation of an invalid virtual machine host name."
  }
}

variable "name" {
  description = "The name of the Azure SQL Managed Instance Failover resource. If provided, this will override the auto-generated name."
  type        = string
  default     = null
}

variable "managed_instance_name" {
  description = "The name of the Azure SQL Managed Instance which will be replicated using a Managed Instance Failover Group."
  type        = string
  default     = null
}

variable "partner_managed_instance_id" {
  description = "The ID of the Azure SQL Managed Instance which will be replicated to."
  type        = string
  default     = null
}

variable "endpoint_failover_policy_mode" {
  description = "The failover mode."
  type        = string
  default     = "Automatic"
  validation {
    condition     = contains(["Automatic", "Manual"], var.endpoint_failover_policy_mode)
    error_message = "Invalid failover policy mode. Allowed values are 'Automatic' and 'Manual'."
  }
}

variable "endpoint_failover_policy_auto_grace_minutes" {
  description = "Applies only if mode is Automatic. The grace period in minutes before failover with data loss is attempted."
  type        = number
  default     = 60
}
