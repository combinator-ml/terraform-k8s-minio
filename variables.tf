variable "namespace" {
  description = "(Optional) The namespace to install the release into. Defaults to minio-operator"
  type        = string
  default     = "minio-operator"
}

variable "values" {
  description = "(Optional) List of values in raw yaml to pass to helm. See https://github.com/pachyderm/helmchart/blob/master/pachyderm/values.yaml."
  type        = list(string)
  default = [<<EOT
EOT 
  ]
}