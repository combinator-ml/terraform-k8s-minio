resource "helm_release" "operator" {
  name             = "minio"
  repository       = "https://operator.min.io/"
  chart            = "minio-operator"
  version          = "4.0.5"
  namespace        = var.operator_namespace
  wait             = true
  values           = var.values
  create_namespace = true
}

# 1. Get the JWT for logging in to the console:
#   kubectl get secret $(kubectl get serviceaccount console-sa --namespace minio-operator -o jsonpath="{.secrets[0].name}") --namespace minio-operator -o jsonpath="{.data.token}" | base64 --decode 
# 2. Get the Operator Console URL by running these commands:
#   kubectl --namespace default port-forward svc/console 9090:9090
#   echo "Visit the Operator Console at http://127.0.0.1:9090"
