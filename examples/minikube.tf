provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "kubernetes-alpha" {
  config_path = "~/.kube/config"
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "minio" {
  source = "../"
}
