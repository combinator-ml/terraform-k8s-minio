resource "random_password" "minio_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "access" {
  count = var.enable_tenant ? length(data.kubectl_file_documents.manifests.documents) : 0
  metadata {
    name      = local.minio_credentials_secret_name
    namespace = var.tenant_namespace
  }

  data = {
    accesskey = var.MINIO_ROOT_USER
    secretkey = random_password.minio_password.result
  }

  type = "Opaque"
}

resource "random_password" "passphrase" {
  length  = 16
  special = true
}

resource "random_password" "salt" {
  length  = 16
  special = true
}

resource "random_password" "console_password" {
  length  = 16
  special = false
}

resource "kubernetes_secret" "console" {
  count = var.enable_tenant ? length(data.kubectl_file_documents.manifests.documents) : 0

  metadata {
    name      = "minio-tenant-console-secret"
    namespace = var.tenant_namespace
  }

  data = {
    CONSOLE_PBKDF_PASSPHRASE = random_password.passphrase.result
    CONSOLE_PBKDF_SALT       = random_password.salt.result
    CONSOLE_ACCESS_KEY : var.CONSOLE_ACCESS_KEY
    CONSOLE_SECRET_KEY : random_password.console_password.result
  }

  type = "Opaque"
}

data "kubectl_file_documents" "manifests" {
  content = file("${path.module}/tenant.yaml")
}

resource "kubectl_manifest" "tenant" {
  count              = var.enable_tenant ? length(data.kubectl_file_documents.manifests.documents) : 0
  yaml_body          = element(data.kubectl_file_documents.manifests.documents, count.index)
  override_namespace = var.tenant_namespace
  depends_on = [
    helm_release.operator,
  ]
}