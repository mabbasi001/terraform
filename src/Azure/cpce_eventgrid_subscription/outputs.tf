output "id" {
  value       = azurerm_eventgrid_event_subscription.eventgrid_event_subscription.id
  description = "The id of the eventgrid event subscription"
}

output "name" {
  value       = azurerm_eventgrid_event_subscription.eventgrid_event_subscription.name
  description = "The name of the eventgrid event subscription"
}