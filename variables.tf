variable "operator_namespace" {
  description = "(Optional) The namespace to install the minio operator into. Defaults to minio-operator"
  type        = string
  default     = "minio-operator"
}

variable "tenant_namespace" {
  description = "(Optional) The namespace to install the minio tenant into. Defaults to default"
  type        = string
  default     = "default"
}

variable "MINIO_ROOT_USER" {
  description = "(Optional) The tenant's root username. Defaults to minio"
  type        = string
  default     = "minio"
}

variable "CONSOLE_ACCESS_KEY" {
  description = "(Optional) The Minio console username."
  type        = string
  default     = "admin"
}

variable "values" {
  description = "(Optional) List of values in raw yaml to pass to helm. See https://github.com/pachyderm/helmchart/blob/master/pachyderm/values.yaml."
  type        = list(string)
  default = [<<EOT
operator:
  clusterDomain: ""
  nsToWatch: ""
  image:
    repository: minio/operator
    tag: v4.0.5
    pullPolicy: IfNotPresent
  imagePullSecrets: []
  replicaCount: 1
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
    runAsNonRoot: true
  resources:
    requests:
      cpu: 200m
      memory: 256Mi
      ephemeral-storage: 500Mi
console:
  image:
    repository: minio/console
    tag: v0.6.3
    pullPolicy: IfNotPresent
  replicaCount: 1
  resources: {}
tenants: {}
EOT 
  ]
}

variable "enable_tenant" {
  description = "(Optional) Enable the deployment of an example minio client."
  type        = bool
  default     = true
}
