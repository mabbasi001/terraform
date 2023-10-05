# Mandatory
variable "resource_group_name" {
  description = "The name of the resource group this resource will be put."
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network in which the subnet should exist."
  type        = string
}
variable "address_prefixes" {
  description = "The address spaces to be allocated to the subnet, all elements should be in CIDR format."
  type        = list(string)
}

# Optional
variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}

variable "generate_azurecaf_name" {
  description = "Determines whether the resource should use the AzureCAF name generation (true) or use the custom CPCE method (false)."
  type        = bool
  default     = false
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource."
  type        = string
  default     = ""
}
variable "name" {
  description = "The override name for the resource."
  type        = string
  default     = null
}
variable "nsg_id" {
  description = "The ID of the NSG that should control all network traffic to/from resources within the subnet."
  type        = string
  default     = null
}
variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway to be used for all outbound traffic from resources within the subnet."
  type        = string
  default     = null
}
variable "service_endpoints" {
  description = "An array of service endpoint objects specifying which Azure resources, in which regions, can be accessed by resources within this subnet over the Azure backbone."
  type        = list(string)
  default     = []
}
variable "route_table_id" {
  description = "The ResourceID of the Route Table that should be associated to the subnet."
  type        = string
  default     = null
}
variable "delegation" {
  description = "A list of objects detailing to which Azure Service this subnet is delegated."
  type = list(object({
    name         = string,
    service_name = string,
    actions      = list(string)
  }))
  default = []
}

