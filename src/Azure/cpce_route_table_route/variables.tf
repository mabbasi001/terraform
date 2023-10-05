variable "resource_group_name" {
  description = "The name of the resource group. Changing this forces a new resource to be created."
  type        = string
}

variable "route" {
  type = object({
    name                   = string
    route_table_name       = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  })
}