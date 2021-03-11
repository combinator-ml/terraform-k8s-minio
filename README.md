# minio

Minio terraform module for combinator.ml

## Building

### Rebuilding the Minio Tenant Example

Terraform doesn't have a nice way of dealing with Kubernetes yaml files, but it does have nice Kubernetes primitives. The minio tenant example is based upon [this example](https://github.com/minio/operator/blob/master/examples/tenant.yaml).

To convert this file to terraform you can use [k2tf](https://github.com/sl1pm4t/k2tf).

```
wget https://raw.githubusercontent.com/minio/operator/v4.0.2/examples/tenant.yaml
k2tf -f tenant.yaml
```

But unfortunately it doesn't convert CRDs. So you'll have to update that yourself.