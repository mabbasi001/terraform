variable "resource_group_name" {
  description = "The name of the resource group in which application gateway to be created. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist."
  type        = string
}

variable "customer_code" {
  description = "The code of the customer for which this resource was created."
  type        = string
  default     = null
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")."
  type        = string
  default     = null
}

variable "firewall" {
  description = "route table to configure routes"
  type = object({
    name               = string
    sku_name           = string
    sku_tier           = string
    firewall_policy_id = string
  })
}

variable "ip_configuration" {
  description = "route table to configure routes"
  type = object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  })
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
