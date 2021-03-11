output "namespace" {
  description = "Namespace is the kubernetes namespace of the minio operator."
  value       = helm_release.operator.namespace
}