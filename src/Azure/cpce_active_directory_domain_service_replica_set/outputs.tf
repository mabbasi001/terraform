output "id" {
  description = "The ID of the Azure Active Directory Domain Service Replica Set."
  value = azurerm_active_directory_domain_service_replica_set.replica_set.id
}

output "domain_controller_ip_addresses" {
  description = "A list of the IP addresses for the domain controllers (typically two)."
  value = azurerm_active_directory_domain_service_replica_set.replica_set.domain_controller_ip_addresses
}

output "external_access_ip_address" {
  description = "The publicly routable IP address for the domain controllers in this Replica Set."
  value = azurerm_active_directory_domain_service_replica_set.replica_set.external_access_ip_address
}
