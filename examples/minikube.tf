provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "minio" {
  source        = "../"
  enable_tenant = true
}

output "tenant_namespace" {
  description = "Namespace is the kubernetes namespace of the minio operator."
  value       = module.minio.tenant_namespace
}

output "MINIO_ROOT_USER" {
  description = "Minio root username."
  value       = module.minio.MINIO_ROOT_USER
}

output "MINIO_ROOT_PASSWORD" {
  description = "Minio root password"
  value       = module.minio.MINIO_ROOT_PASSWORD
}

output "CONSOLE_ACCESS_KEY" {
  description = "Minio console username."
  value       = module.minio.CONSOLE_ACCESS_KEY
}

output "CONSOLE_SECRET_KEY" {
  description = "Minio console password"
  value       = module.minio.CONSOLE_SECRET_KEY
}