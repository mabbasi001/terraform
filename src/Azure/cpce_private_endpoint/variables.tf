variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "resource_identifier" {
  description = "The code of the resource identifier in the name"
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

variable "name" {
  description = "The name of the sql server"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The name of the subnet to associate this private endpoint to."
  type        = string
  default     = null
}

variable "private_dns_zone_ids" {
  description = "List of private dns zones to associate to."
  type        = list(string)
  default     = null
}

variable "private_dns_zone_name" {
  description = "Specifies the Name of the Private DNS Zone Group."
  type        = string
  default     = null
}

variable "private_connection_approval_is_manual" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner?"
  type        = bool
  default     = false
}

variable "private_connection_resource_id" {
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
  type        = string
  default     = null
}

variable "private_connection_subresource_names" {
  description = <<-DESCRIPTION
    A list of subresource names which the Private Endpoint is able to connect to.  Examples include; sqlServer, blob, file.
    Full list here: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource.
  DESCRIPTION
  type        = list(string)
  default     = null
}
