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

variable "application_gateway_certificate_notification_days_before_expiry" {
  description = "Number of days before the certificates' expiry dates when a notification will be generated."
  type        = number
  default     = 90
}

variable "name" {
  description = "The override name for the resource"
  type        = string
  default     = null
}

variable "application_gateway_sku" {
  description = "SKU for application gateway."
  default     = "WAF_v2"
  type        = string
}

variable "application_gateway_tier" {
  description = "Tier for application gateway."
  default     = "WAF_v2"
  type        = string
}

variable "application_gateway_capacity" {
  description = "Capacity for application gateway."
  default     = 2
  type        = number
}

variable "firewall_mode" {
  description = "WAF default mode."
  default     = "Prevention"
  type        = string
}

variable "waf_enabled" {
  description = "Boolean to toggle WAF."
  default     = true
  type        = bool
}

variable "rule_set_version" {
  description = "WAF ruleset version."
  default     = "3.2"
  type        = string
}

variable "rule_set_type" {
  description = "WAF ruleset type"
  default     = "OWASP"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault where SSL certificate is uploaded and used from"
  default     = null
  type        = string
}

variable "application_gateway_certificates" {
  description = "Details of the required cpce application gateway certificates."
  type = map(object({
    type     = string
    pfx_path = string
    key_type = string
    key_size = number
  }))
}

variable "application_gateway_certificate_passwords" {
  description = <<-DESCRIPTION
    Password of the pfx files containing the Application gateway certificates.
    Note: The keys must match those defined in the application_gateway_certificates map.
  DESCRIPTION
  type        = map(string)
  sensitive   = true
}

variable "frontend_ports" {
  description = "Frontend port Configurations."
  type = map(object({
    port = number # (Required) The port used for this Frontend Port.
  }))
  validation {
    condition     = alltrue([for my_object in var.frontend_ports : my_object.port >= 1 && my_object.port <= 65535])
    error_message = "All 'port' must be in range from 1 to 65535."
  }
}

variable "gateway_ip_configurations" {
  description = "Gateway IP configurations."
  type = map(object({
    subnet_id = string #  (Required) The ID of the Subnet which the Application Gateway should be connected to.
  }))
}

variable "backend_address_pools" {
  description = "List of backend address pools."
  type = map(object({
    fqdns        = list(string) # (Optional) A list of FQDN's which should be part of the Backend Address Pool.
    ip_addresses = list(string) # (Optional) A list of IP Addresses which should be part of the Backend Address Pool.
  }))
}

variable "url_path_maps" {
  description = "Url path maps."
  type = map(object({
    default_backend_address_pool_key = string # (Optional) The key of an associated member from 'backend_address_pools' map.
    default_backend_http_setting_key = string # (Optional) The key of an associated member from 'backend_http_settings' map.

    path_rules = map(object({
      paths                    = list(string) # (Required) A list of Paths used in this Path Rule.
      backend_address_pool_key = string       # (Optional) The key of an associated member from 'backend_address_pools' map.
      backend_http_setting_key = string       # (Optional) The key of an associated member from 'backend_http_settings' map.
    }))
  }))
}

variable "backend_http_settings" {
  description = "Backend HTTP settings."
  type = map(object({
    cookie_based_affinity               = string       # (Required) Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled.
    affinity_cookie_name                = string       # (Optional) The name of the affinity cookie.
    path                                = string       # (Optional) The Path which should be used as a prefix for all HTTP requests.
    port                                = number       # (Required) The port which should be used for this Backend HTTP Settings Collection.
    probe_key                           = string       # (Optional) The key of an associated member from 'probes' map.
    protocol                            = string       # (Required) The Protocol which should be used. Possible values are Http and Https.
    request_timeout                     = number       # (Required) The request timeout in seconds, which must be between 1 and 86400 seconds.
    host_name                           = string       # (Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true.
    pick_host_name_from_backend_address = bool         # (Optional) Whether host header should be picked from the host name of the backend server. Defaults to false.
    authentication_certificate_names    = list(string) # (Optional) The name of the Authentication Certificate.
    trusted_root_certificate_names      = list(string) # (Optional) A list of trusted_root_certificate names.

    connection_draining = object({ # (Optional) A connection_draining block.
      enabled           = bool,    # (Required) If connection draining is enabled or not.
      drain_timeout_sec = number   # (Required) The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds.
    })
  }))
  validation {
    condition     = alltrue([for my_object in var.backend_http_settings : contains(["Enabled", "Disabled"], my_object.cookie_based_affinity)])
    error_message = "All 'cookie_based_affinity' must be of value 'Enabled' or 'Disabled'."
  }
  validation {
    condition     = alltrue([for my_object in var.backend_http_settings : my_object.port == null ? true : (my_object.port >= 1 && my_object.port <= 65535)])
    error_message = "All 'port' must be in range from 1 to 65535."
  }
  validation {
    condition     = alltrue([for my_object in var.backend_http_settings : contains(["Http", "Https"], my_object.protocol)])
    error_message = "All 'protocol' must be of value 'Http' or 'Https'."
  }
  validation {
    condition     = alltrue([for my_object in var.backend_http_settings : my_object.request_timeout >= 1 && my_object.request_timeout <= 86400])
    error_message = "All 'request_timeout' must be in range from 1 to 86400 seconds."
  }
  validation {
    condition     = alltrue([for my_object in var.backend_http_settings : my_object.connection_draining == null ? true : (my_object.connection_draining.drain_timeout_sec >= 1 && my_object.connection_draining.drain_timeout_sec <= 3600)])
    error_message = "All 'connection_draining' must be in range from 1 to 3600."
  }
}

variable "frontend_ip_configurations" {
  description = "Frontend IP Configurations."
  type = map(object({
    subnet_id          = string # (Optional) The ID of the Subnet.
    private_ip_address = string # (Optional) The Private IP Address to use for the Application Gateway.
    # public_ip_address_id        = string # (Optional) The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the sku of this Application Gateway. Please refer to the Azure documentation for public IP addresses for details.
    private_ip_address_allocation = string # (Optional) The Allocation Method for the Private IP Address. Possible values are Dynamic and Static.  }))
  }))
  validation {
    condition     = alltrue([for my_object in var.frontend_ip_configurations : my_object.private_ip_address_allocation == null ? true : contains(["Dynamic", "Static"], my_object.private_ip_address_allocation)])
    error_message = "All 'private_ip_address_allocation' must be of value 'Dynamic' or 'Static'."
  }
}

variable "http_listeners" {
  description = "HTTP listeners."
  type = map(object({
    frontend_ip_configuration_key = string       # (Required) The key of an associated member from 'frontend_ip_configurations' map.
    frontend_port_key             = string       # (Required) The key of an associated member from 'frontend_ports' map.
    host_name                     = string       # (Optional) The Hostname which should be used for this HTTP Listener. Setting this value changes Listener Type to 'Multi site'.
    host_names                    = list(string) # (Optional) A list of Hostname(s) should be used for this HTTP Listener. It allows special wildcard characters.
    protocol                      = string       # (Required) The Protocol to use for this HTTP Listener. Possible values are Http and Https.
    require_sni                   = bool         # (Optional) Should Server Name Indication be Required? Defaults to false.
    ssl_certificate_key           = string       # (Optional) The key of an associated member from 'ssl_certificates' map.
    firewall_policy_id            = string       # (Optional) The ID of the Web Application Firewall Policy which should be used as a HTTP Listener.

    custom_error_configurations = list(object({ # (Optional) One or more custom_error_configuration blocks as defined below.
      status_code           = string            # (Required) Status code of the application gateway customer error. Possible values are HttpStatus403 and HttpStatus502
      custom_error_page_url = string            # (Required) Error page URL of the application gateway customer error.
    }))
  }))
  validation {
    condition     = alltrue([for my_object in var.http_listeners : contains(["Http", "Https"], my_object.protocol)])
    error_message = "All 'protocol' must be of value 'Http' or 'Https'."
  }
  validation {
    condition     = alltrue([for my_object in var.http_listeners : alltrue([for custom_error_configuration in my_object.custom_error_configurations : contains(["HttpStatus403", "HttpStatus502"], custom_error_configuration.status_code)])])
    error_message = "All 'status_code' must be of value 'HttpStatus403' or 'HttpStatus502'."
  }
}

variable "request_routing_rules" {
  description = "Request routing rules."
  type = map(object({
    rule_type                   = string # (Required) The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.
    http_listener_key           = string # (Required) The key of an associated member from 'http_listeners' map.
    backend_address_pool_key    = string # (Optional) The key of an associated member from 'backend_address_pools' map.
    backend_http_setting_key    = string # The key of an associated member from 'backend_http_settings' map.
    redirect_configuration_name = string # (Optional) The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either backend_address_pool_name or backend_http_settings_name is set.
    rewrite_rule_set_name       = string # (Optional) The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs.
    url_path_map_key            = string # (Optional) The key of an associated member from 'url_path_maps' map.
  }))
  validation {
    condition     = alltrue([for my_object in var.request_routing_rules : contains(["Basic", "PathBasedRouting"], my_object.rule_type)])
    error_message = "All 'rule_type' must be of value 'Http' or 'Https'."
  }
}

variable "probes" {
  description = "List of probes."
  type = map(object({
    host                                      = string # (Optional) The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. Cannot be set if pick_host_name_from_backend_http_settings is set to true.
    interval                                  = number # (Required) The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds.
    protocol                                  = string # (Required) The Protocol used for this Probe. Possible values are Http and Https.
    path                                      = string # (Required) The Path used for this Probe.
    timeout                                   = number # (Required) The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds.
    unhealthy_threshold                       = number # (Required) The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 seconds.
    port                                      = number # (Optional) Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Standard_v2 and WAF_v2 only.
    pick_host_name_from_backend_http_settings = bool   # (Optional) Whether the host header should be picked from the backend http settings. Defaults to false.
    minimum_servers                           = number # (Optional) The minimum number of servers that are always marked as healthy. Defaults to 0.

    match = object({             # (Optional) A match block.
      body        = string       # (Optional) A snippet from the Response Body which must be present in the Response..
      status_code = list(string) # (Optional) A list of allowed status codes for this Health Probe.
    })
  }))
  default = {}
  validation {
    condition     = alltrue([for my_object in var.probes : my_object.interval >= 1 && my_object.interval <= 86400])
    error_message = "All 'interval' must be in range from 1 to 86400 seconds."
  }
  validation {
    condition     = alltrue([for my_object in var.probes : contains(["Http", "Https"], my_object.protocol)])
    error_message = "All 'protocol' must be of value 'Http' or 'Https'."
  }
  validation {
    condition     = alltrue([for my_object in var.probes : my_object.timeout >= 1 && my_object.timeout <= 86400])
    error_message = "All 'timeout' must be in range from 1 to 86400 seconds."
  }
  validation {
    condition     = alltrue([for my_object in var.probes : my_object.unhealthy_threshold >= 1 && my_object.unhealthy_threshold <= 20])
    error_message = "All 'unhealthy_threshold' must be in range from 1 to 20 seconds."
  }
  validation {
    condition     = alltrue([for my_object in var.probes : my_object.port == null ? true : (my_object.port >= 1 && my_object.port <= 65535)])
    error_message = "All 'port' must be in range from 1 to 65535."
  }
}

variable "tags" {
  description = "A map of tags that should be assigned to the resource."
  type        = map(string)
  default     = {}
}
