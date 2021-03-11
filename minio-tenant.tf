resource "kubernetes_secret" "minio_creds_secret" {
  metadata {
    name = "minio-creds-secret"
  }

  data = {
    accesskey = "minio"
    secretkey = "minio123"
  }

  type = "Opaque"
}

resource "kubernetes_secret" "console_secret" {
  metadata {
    name = "console-secret"
  }

  data = {
    CONSOLE_ACCESS_KEY       = "YOURCONSOLEACCESS"
    CONSOLE_PBKDF_PASSPHRASE = "SECRET"
    CONSOLE_PBKDF_SALT       = "SECRET"
    CONSOLE_SECRET_KEY       = "YOURCONSOLESECRET"
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "tenant" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "minio.min.io/v2"
    "kind"       = "Tenant"
    "metadata" = {
      "annotations" = {
        "prometheus.io/path"   = "/minio/prometheus/metrics"
        "prometheus.io/port"   = "9000"
        "prometheus.io/scrape" = "true"
      }
      "labels" = {
        "app" = "minio"
      }
      "name" = "minio"
    }
    "spec" = {
      "certConfig" = {
        "commonName"       = ""
        "dnsNames"         = []
        "organizationName" = []
      }
      "console" = {
        "consoleSecret" = {
          "name" = "console-secret"
        }
        "image"    = "minio/console:v0.6.3"
        "replicas" = 2
        "securityContext" = {
          "runAsGroup"   = 2000
          "runAsNonRoot" = true
          "runAsUser"    = 1000
        }
      }
      "credsSecret" = {
        "name" = "minio-creds-secret"
      }
      "image"               = "minio/minio:RELEASE.2021-03-01T04-20-55Z"
      "imagePullPolicy"     = "IfNotPresent"
      "mountPath"           = "/export"
      "podManagementPolicy" = "Parallel"
      "pools" = [
        {
          "securityContext" = {
            "runAsGroup"   = 1000
            "runAsNonRoot" = true
            "runAsUser"    = 1000
          }
          "servers" = 4
          "volumeClaimTemplate" = {
            "metadata" = {
              "name" = "data"
            }
            "spec" = {
              "accessModes" = [
                "ReadWriteOnce",
              ]
              "resources" = {
                "requests" = {
                  "storage" = "1Ti"
                }
              }
            }
          }
          "volumesPerServer" = 4
        },
      ]
      "requestAutoCert" = true
      "s3" = {
        "bucketDNS" = false
      }
      "serviceMetadata" = {
        "consoleServiceAnnotations" = {
          "v2.min.io" = "console-svc"
        }
        "consoleServiceLabels" = {
          "label" = "console-svc"
        }
        "minioServiceAnnotations" = {
          "v2.min.io" = "minio-svc"
        }
        "minioServiceLabels" = {
          "label" = "minio-svc"
        }
      }
    }
  }
  depends_on = [helm_release.minio_operator]
}