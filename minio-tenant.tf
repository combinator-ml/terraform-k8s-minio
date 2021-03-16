resource "random_password" "root_password" {
  length  = 16
  special = true
}

resource "kubernetes_secret" "access" {
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
  metadata {
    name      = "console-secret"
    namespace = var.tenant_namespace
  }

  data = {
    CONSOLE_PBKDF_PASSPHRASE = base64encode(random_password.passphrase.result)
    CONSOLE_PBKDF_SALT       = base64encode(random_password.salt.result)
    CONSOLE_ACCESS_KEY       = base64encode("admin")
    CONSOLE_SECRET_KEY       = base64encode(random_password.console_password.result)
  }

  type = "Opaque"
}

data "kubectl_file_documents" "manifests" {
  content = file("${path.module}/tenant.yaml")
}

resource "kubectl_manifest" "tenant" {
  count              = length(data.kubectl_file_documents.manifests.documents)
  yaml_body          = element(data.kubectl_file_documents.manifests.documents, count.index)
  override_namespace = var.tenant_namespace
  depends_on = [
    helm_release.operator,
  ]
}