resource "random_password" "root_password" {
  length  = 16
  special = true
}

resource "kubernetes_secret" "access" {
  count = var.enable_tenant ? length(data.kubectl_file_documents.manifests.documents) : 0
  metadata {
    name      = "minio-creds-secret"
    namespace = var.tenant_namespace
  }

  data = {
    accesskey = base64encode(var.MINIO_ROOT_USER)
    secretkey = base64encode(random_password.root_password.result)
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
  special = true
}

resource "kubernetes_secret" "console" {
  count = var.enable_tenant ? length(data.kubectl_file_documents.manifests.documents) : 0

  metadata {
    name      = "console-secret"
    namespace = var.tenant_namespace
  }

  data = {
    CONSOLE_PBKDF_PASSPHRASE = base64encode(random_password.passphrase.result)
    CONSOLE_PBKDF_SALT       = base64encode(random_password.salt.result)
    CONSOLE_ACCESS_KEY       = base64encode(var.CONSOLE_ACCESS_KEY)
    CONSOLE_SECRET_KEY       = base64encode(random_password.console_password.result)
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