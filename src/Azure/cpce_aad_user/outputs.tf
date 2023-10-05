output "object_id" {
  description = "The ObjectID of the AAD user being created."
  value       = azuread_user.cpce_aad_user.object_id
}

output "domain_name" {
  description = "The Domain Name of the AAD user being created."
  value       = azuread_user.cpce_aad_user.onpremises_domain_name
}

output "user_principal_name" {
  description = "The Domain User Principal Name of the AAD user being created."
  value       = azuread_user.cpce_aad_user.onpremises_user_principal_name
}
