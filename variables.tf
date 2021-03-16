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

variable "values" {
  description = "(Optional) List of values in raw yaml to pass to helm. See https://github.com/pachyderm/helmchart/blob/master/pachyderm/values.yaml."
  type        = list(string)
  default = [<<EOT
EOT 
  ]
}