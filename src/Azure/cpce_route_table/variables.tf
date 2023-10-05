variable "resource_group_name" {
  description = "The name of the resource group. Changing this forces a new resource to be created."
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

variable "route_table" {
  description = "route table to configure routes"
  type = object({
    name                          = string
    disable_bgp_route_propagation = bool
  })
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
