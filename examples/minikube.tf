provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "minio" {
  source = "../"
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