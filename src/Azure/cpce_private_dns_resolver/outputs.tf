output "id" {
  value       = azurerm_private_dns_resolver.hub_resolver.id
  description = "The ID of the resource"
  sensitive   = true
}

output "name" {
  value       = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  description = "The name of the resource"
  sensitive   = true
}

output "outbound_endpoints" {
  value       = [ for endpoint in azurerm_private_dns_resolver_outbound_endpoint.hub_resolver_outbound_endpoint : endpoint.id ]
  description = "The outbound endpoints for resolver"
  sensitive   = true
}
