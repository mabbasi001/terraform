output "id" {
  description = "the id for the azurerm_lb resource"
  value       = azurerm_lb.lb.id
}

output "name" {
  description = "Name of the Load Balancer resource"
  value       = azurerm_lb.lb.name
}

output "frontend_ip_configuration" {
  description = "Details of the Frontend IP Configuration of the Load Balancer"
  value       = azurerm_lb.lb.frontend_ip_configuration
}

output "backend_address_pool_id" {
  description = "Resource ID of the Load Balancer backend address pool."
  value       = azurerm_lb_backend_address_pool.backend.id
}