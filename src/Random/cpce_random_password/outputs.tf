output "result" {
  value       = random_password.cpce_random_password.result
  description = "The generated random string."
  sensitive   = true
}
