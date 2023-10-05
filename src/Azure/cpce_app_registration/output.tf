output "client_secret" {
  description = "Client Secret"
  value       = try(azuread_application_password.application[0].value, "")
  sensitive   = true
}

output "client_secret_name" {
  description = "client secret name"
  value       = local.secret_name
}

output "client_id" {
  description = "Client Id"
  value       = azuread_application.application.application_id
}

output "service_principal_object_id" {
  description = "Service Principal Object Id"
  value       = azuread_service_principal.application.object_id
}

output "app_id_uri" {
  description = "app id uri"
  value       = local.app_id_url
}

output "app_role_ids" {
  description = "app_role_ids passthrough from resource azuread_application"
  value       = azuread_application.application.app_role_ids
}

output "display_name" {
  description = "display name of AzureAD app reg"
  value       = azuread_application.application.display_name
}

output "down_stream_apis" {
  description = "application_id and app_id_uri for downstream apis"
  value = { for key, item in local.api_permissions : item.original_name => tomap({
    application_id = local.api_permissions_enriched[key].application_id,
    app_id_uri = local.api_permissions_enriched[key].app_id_uri
  }) }
}

