variable "resource_group_name" {
  description = "The name of the resource group in which this virtual machine should exist."
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
  description = "The name of the apim resource. If provided, this will override the auto-generated name."
  type        = string
  default     = null
}

variable "sku_name" {
  type        = string
  description = "String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity"
  default     = "Basic_1"
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
}

variable "additional_location" {
  description = "List of the name of the Azure Region in which the API Management Service should be expanded to."
  type = map(object({
    location             = string
    zones                = list(number)
    capacity             = string
    public_ip_address_id = string
    subnet_id            = string
  }))
  default = {}
}

variable "zones" {
  type        = list(number)
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  default     = null
}

variable "certificate_configuration" {
  type        = list(map(string))
  description = "List of certificate configurations"
  default     = []
}

variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
  default     = false
}

variable "gateway_disabled" {
  type        = bool
  description = "(Optional) Disable the gateway in main region? This is only supported when `additional_location` is set."
  default     = false
}

variable "min_api_version" {
  type        = string
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  default     = null
}

variable "enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?"
  default     = false
}

variable "management_hostname_configuration" {
  type        = list(map(string))
  description = "List of management hostname configurations"
  default     = []
}

variable "scm_hostname_configuration" {
  type        = list(map(string))
  description = "List of scm hostname configurations"
  default     = []
}

variable "proxy_hostname_configuration" {
  type        = list(map(string))
  description = "List of proxy hostname configurations"
  default     = []
}

variable "portal_hostname_configuration" {
  type        = list(map(string))
  description = "Legacy portal hostname configurations"
  default     = []
}

variable "developer_portal_hostname_configuration" {
  type        = list(map(string))
  description = "Developer portal hostname configurations"
  default     = []
}

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent"
  default     = null
}

variable "policy_configuration" {
  type        = map(string)
  description = "Map of policy configuration"
  default     = {}
}

variable "enable_sign_in" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "enable_sign_up" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "terms_of_service_configuration" {
  type        = list(map(string))
  description = "Map of terms of service configuration"

  default = [{
    consent_required = false
    enabled          = false
    text             = ""
  }]
}

variable "security_configuration" {
  type        = map(string)
  description = "Map of security configuration"
  default     = {}
}

### NETWORKING

variable "virtual_network_type" {
  type        = string
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  default     = null
}

variable "virtual_network_configuration" {
  type        = list(string)
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
  default     = []
}

### IDENTITY

variable "identity_type" {
  description = "Type of Managed Service Identity that should be configured on this API Management Service"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned."
  type        = list(string)
  default     = []
}

variable "public_ip_address_id" {
  description = "public ip address id needed if apim is external"
  type        = string
  default     = null
}


