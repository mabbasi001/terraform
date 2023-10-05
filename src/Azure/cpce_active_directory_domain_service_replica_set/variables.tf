variable "customer_code" {
  description = "A code representing the customer for which this Hub is being provisioned. Changing this forces the resource to be destroyed/recreated."
  type        = string
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. 'TEST' or 'PROD'). Changing this forces the resource to be destroyed/recreated."
  type        = string
}

variable "name_suffix" {
  description = "The suffix to be appended to all the AADDS replica resources to make their names unique within the Resource Group."
  type        = string
  default     = "aaddsreplica01"
}

variable "location" {
  description = "The Azure Region in which the AADDS replica set should be created."
  type        = string
}

variable "subnet_id" {
  description = "The subnet to associate the replica set to."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to which the replica set is to be associated."
  type        = string
}

variable "azure_active_directory_domain_service" {
  description = "The ID of the Azure Active Directory Domain Service resource to which this replica set belongs."
  type = object({
    id                             = string
    domain_controller_ip_addresses = list(string)
  })
}
