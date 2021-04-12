# minio

Minio terraform module for combinator.ml

## Usage

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

- Left over certificate signing requests

The minio automatic signing request feature creates left over CSRs in k8s. You will need to delete these before reinstalling.

## Debugging

### Connect to Minio via MC

```bash
kubectl run -i -t mc --image=minio/mc --command /bin/sh
mc alias set minio https://minio.default.svc.cluster.local minio zxJ4eKM7rYcu0XPA --insecure
mc --insecure mb minio/pachyderm
mc --insecure ls minio/
```