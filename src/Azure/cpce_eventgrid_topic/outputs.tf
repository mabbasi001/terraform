output "id" {
  value       = azurerm_eventgrid_topic.eventgrid_topic.id
  description = "The id of the eventgrid topic"
}

output "name" {
  value       = azurerm_eventgrid_topic.eventgrid_topic.name
  description = "The name of the eventgrid topic"
}

output "endpoint" {
  value       = azurerm_eventgrid_topic.eventgrid_topic.endpoint
  description = "The endpoint of the eventgrid topic"
}

output "primary_access_key" {
  value       = azurerm_eventgrid_topic.eventgrid_topic.primary_access_key
  sensitive   = true
  description = "The primary access key of the eventgrid topic"
}

output "secondary_access_key" {
  value       = azurerm_eventgrid_topic.eventgrid_topic.secondary_access_key
  sensitive   = true
  description = "The secondary access key of the eventgrid topic"
}
