# terraform-k8s-minio

Minio terraform module for combinator.ml

## Usage

```terraform
module "minio" {
  source  = "combinator-ml/minio/k8s"
  version = "0.0.1"
}
```

See the full configuration options below.

### Stack Creation

```bash
KUBE_CONFIG_PATH=~/.kube/config terraform apply
```

### Stack Deletion

```bash
KUBE_CONFIG_PATH=~/.kube/config terraform destroy
```

## Known Issues

- Why do you have to explicitly export the Kubernetes config?

I found that hardcoding the kubeconfig led to [this terraform bug](https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1234).

## Requirements

| Name | Version |
|------|---------|
| kubectl | >= 1.7.0 |
| provider | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubectl | >= 1.7.0 |
| kubernetes | n/a |
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) |
| [kubectl_file_documents](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) |
| [kubectl_manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) |
| [kubernetes_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) |
| [random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| CONSOLE\_ACCESS\_KEY | (Optional) The Minio console username. | `string` | `"admin"` | no |
| MINIO\_ROOT\_USER | (Optional) The tenant's root username. Defaults to minio | `string` | `"minio"` | no |
| enable\_tenant | (Optional) Enable the deployment of an example minio client. | `bool` | `true` | no |
| operator\_namespace | (Optional) The namespace to install the minio operator into. Defaults to minio-operator | `string` | `"minio-operator"` | no |
| tenant\_namespace | (Optional) The namespace to install the minio tenant into. Defaults to default | `string` | `"default"` | no |
| values | (Optional) List of values in raw yaml to pass to helm. See https://github.com/pachyderm/helmchart/blob/master/pachyderm/values.yaml. | `list(string)` | <pre>[<br>  "operator:\n  clusterDomain: \"\"\n  nsToWatch: \"\"\n  image:\n    repository: minio/operator\n    tag: v4.0.5\n    pullPolicy: IfNotPresent\n  imagePullSecrets: []\n  replicaCount: 1\n  securityContext:\n    runAsUser: 1000\n    runAsGroup: 1000\n    runAsNonRoot: true\n  resources:\n    requests:\n      cpu: 200m\n      memory: 256Mi\n      ephemeral-storage: 500Mi\nconsole:\n  image:\n    repository: minio/console\n    tag: v0.6.3\n    pullPolicy: IfNotPresent\n  replicaCount: 1\n  resources: {}\ntenants: {}\n"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| CONSOLE\_ACCESS\_KEY | Minio console username |
| CONSOLE\_SECRET\_KEY | Minio console password |
| MINIO\_ROOT\_PASSWORD | Minio root password. |
| MINIO\_ROOT\_USER | Minio root username. |
| minio\_endpoint | Minio endpoint |
| minio\_port | Minio port |
| minio\_tenant\_secret\_key\_ref | Name of the kubernetes secret that stores the minio credentials |
| tenant\_namespace | Namespace of the minio tenant. |
