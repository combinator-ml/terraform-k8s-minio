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