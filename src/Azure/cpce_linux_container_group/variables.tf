variable "name" {
  description = "The base name for the resource"
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group where container group should be provisioned"
  type        = string
}

variable "location" {
  description = "The datacentre in which the resource should exist"
  type        = string
}

variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
}

variable "subnet_id" {
  description = "An Id of subnet where containers should be provisioned"
  type        = string
}

variable "acr_server" {
  description = "Hostname of Azure Container Registry instance"
  type        = string
}

variable "acr_username" {
  description = "Username for Azure Container Registry"
  type        = string
}

variable "acr_password" {
  description = "Password for Azure Container Registry"
  type        = string
  sensitive   = true
}

variable "build_agents" {
  description = "Definition of the build agents to host in the Azure Container Instances"
  type = map(list(object({
    name                         = string
    image                        = string
    cpu                          = number
    memory                       = number
    environment_variables        = map(string)
    secure_environment_variables = map(string)
    port                         = optional(number)
  })))
}

variable "restart_policy" {
  type    = string
  default = null
  validation {
    condition     = var.restart_policy == null ? true : contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "Container group restart_policy must either be null (for the default value) or one of the following: Always, Never, OnFailure."
  }
}
