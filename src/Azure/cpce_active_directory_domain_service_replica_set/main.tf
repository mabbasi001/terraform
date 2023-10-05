resource "azurerm_active_directory_domain_service_replica_set" "replica_set" {
  domain_service_id = var.azure_active_directory_domain_service.id
  location          = var.location
  subnet_id         = var.subnet_id
}
