# Kustomize Nu Validation GitHub Action

Validate Kustomize Kubernetes manifests using Kubeconform.

## How to Use

To utilize this action, add the following configuration to your GitHub Actions workflow file (e.g., `.github/workflows/validate-kustomize.yml`):

```yaml
name: Kustomize Nu Validation
on: [push, pull_request]
jobs:
  validate-kustomize:
    runs-on: ubuntu-latest
    steps:
      - uses: omar-luqman/kustomize-nu-validation@v1
```

## Options

| Name                  | Description                                                | Default       |
| --------------------- | ---------------------------------------------------------- | ------------- |
| `entry`               | Comma-separated list of Kustomize directories to validate. | `./kustomize` |
| `kubectl_version`     | Version of `kubectl` to use.                               | `1.30.0`      |
| `kubeconform_version` | Version of `kubeconform` to use.                           | `0.6.6`       |
| `kustomize_version`   | Version of `kustomize` to use.                             | `5.4.1`       |
| `nushell_version`     | Version of `Nushell` to use.                               | `0.93.0`      |
| `python_version`      | Version of `Python` to use.                                | `3.12`        |

## Why Nushell?

Nushell is used in this action because of its ability to provide gorgeous, highly readable output. Its structured data model allows for elegant manipulation and presentation of Kubeconform's JSON results, making it much easier to interpret validation outcomes. This ensures that developers can quickly identify issues in their Kustomize projects and take necessary corrective actions.
