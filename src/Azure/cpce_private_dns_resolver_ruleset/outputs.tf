output "id" {
  value       = azurerm_private_dns_resolver_dns_forwarding_ruleset.hub_resolver_rule_set.id
  description = "The ID of the resource"
  sensitive   = true
}

output "name" {
  value       = var.generate_azurecaf_name ? azurecaf_name.name[0].result : local.name
  description = "The name of the resource"
  sensitive   = true
}
