# Mandatory
variable "name" {
  description = "The base name for the resource"
  type        = string
}

# Optional
variable "app_service_id" {
  description = "The ID of the Linux Web App this Deployment Slot will be part of."
  type        = string
  default     = null
}

# Optional
variable "application_insights_instrumentation_key" {
  description = "The application insights instrumentation key for the resource"
  type        = string
  default     = null
}

# Optional
variable "app_settings" {
  description = "A map of key-value pairs of App Settings"
  type        = map(string)
  default     = {}
}

# Optional
variable "dotnet_version" {
  description = "The version of .NET to use. Possible values include 3.1, 5.0, 6.0 and 7.0"
  type        = string
  default     = "6.0"
}

# Optional
variable "environment_code" {
  description = "A code for the environment in which the resource is being created (e.g. \"BVT\" or \"UAT\")"
  type        = string
  default     = null
}

# Optional
variable "ip_restrictions" {
  description = "A map of ip restrictions to restrict network traffic to the web app by IP"
  type        = list(object({
    action                    = string
    headers                   = list(object({
      x_azure_fdid      = list(string)
      x_fd_health_probe = list(string)
      x_forwarded_for   = list(string)
      x_forwarded_host  = list(string)
    }))
    ip_address                = string
    name                      = string
    priority                  = number
    service_tag               = string
    virtual_network_subnet_id = string
  }))
  default     = []
}

# Optional
variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}

#Optional
variable "virtual_network_subnet_id" {
  description = "The ID of the virtual network subnet for the web app to live"
  type        = string
  default     = null
}