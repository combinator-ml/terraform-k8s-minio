resource "helm_release" "operator" {
  name             = "minio"
  repository       = "https://operator.min.io/"
  chart            = "minio-operator"
  version          = "4.0.2"
  namespace        = var.namespace
  wait             = true
  values           = var.values
  create_namespace = true
}