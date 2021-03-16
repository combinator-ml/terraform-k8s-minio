output "tenant_namespace" {
  description = "Namespace of the minio tenant."
  value       = var.tenant_namespace
}


output "MINIO_ROOT_USER" {
  description = "Minio root username."
  value       = var.MINIO_ROOT_USER
}

output "MINIO_ROOT_PASSWORD" {
  description = "Minio root password."
  value       = random_password.root_password.result
}