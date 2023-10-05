output "id" {
  description = "The ID of the Azure Service Fabric Cluster"
  value       = azurerm_service_fabric_cluster.cluster.id
}

output "name" {
  description = "The name of the Azure Service Fabric Cluster"
  value       = azurerm_service_fabric_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "The cluster endpoint of the Azure Service Fabric Cluster."
  value       = azurerm_service_fabric_cluster.cluster.cluster_endpoint
}

output "load_balancer" {
  description = "Details of the internal Load Balancer that's in front of the Azure Service Fabric Cluster."
  value = {
    id                 = module.internal_load_balancer.id
    name               = module.internal_load_balancer.name
    private_ip_address = module.internal_load_balancer.frontend_ip_configuration[0].private_ip_address
  }
}

output "cpce_encipherment_primary_certificate" {
  description = "Details of the Primary Encipherment Certificate."
  value = {
    id         = azurerm_key_vault_certificate.cluster_certificates["cpce-encipherment-primary"].id
    name       = azurerm_key_vault_certificate.cluster_certificates["cpce-encipherment-primary"].name
    thumbprint = azurerm_key_vault_certificate.cluster_certificates["cpce-encipherment-primary"].thumbprint
  }
}

output "cpce_cluster_certificate" {
  description = "Details of the Cluster Certificate."
  value = {
    id         = azurerm_key_vault_certificate.cluster_certificates["cluster-cert-001"].id
    name       = azurerm_key_vault_certificate.cluster_certificates["cluster-cert-001"].name
    thumbprint = azurerm_key_vault_certificate.cluster_certificates["cluster-cert-001"].thumbprint
  }
}

output "cpce_reverse_proxy_certificate" {
  description = "Details of the Reverse Proxy Certificate."
  value = {
    id         = azurerm_key_vault_certificate.cluster_certificates["reverse-proxy-cert-001"].id
    name       = azurerm_key_vault_certificate.cluster_certificates["reverse-proxy-cert-001"].name
    thumbprint = azurerm_key_vault_certificate.cluster_certificates["reverse-proxy-cert-001"].thumbprint
  }
}

output "virtual_machine_scale_sets" {
  description = "A list of the virtual machine scale sets created to support each of the node types required by the Azure Service Fabric Cluster."
  value = [for scale_set in module.scale_sets : {
    id               = scale_set.id
    unique_id        = scale_set.unique_id
    name             = scale_set.name
    managed_identity = scale_set.managed_identity
  }]
}
