output "tenant_namespace" {
  description = "Namespace of the minio tenant."
  value       = var.enable_tenant ? var.tenant_namespace : ""
}

output "MINIO_ROOT_USER" {
  description = "Minio root username."
  value       = var.enable_tenant ? var.MINIO_ROOT_USER : ""
}

output "MINIO_ROOT_PASSWORD" {
  description = "Minio root password."
  value       = var.enable_tenant ? random_password.root_password.result : ""
}

output "CONSOLE_ACCESS_KEY" {
  description = "Minio console username"
  value       = var.CONSOLE_ACCESS_KEY
}

output "CONSOLE_SECRET_KEY" {
  description = "Minio console password"
  value       = random_password.console_password.result
}