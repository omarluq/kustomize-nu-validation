# Kustomize Nu Validation GitHub Action

Kustomize manifests validations using Kubeconform with beautiful nushell outputs.

![Screenshot 2024-05-12 at 11 46 23 AM](https://github.com/omarluq/kustomize-nu-validation/assets/84993125/40613318-ba70-4b42-9825-84276a975fad)

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

## Optional Inputs

| Name                  | Description                      | Default       |
| --------------------- | -------------------------------- | ------------- |
| `entry`               | Kustomize projects entry point   | `./kustomize` |
| `kubectl_version`     | Version of `kubectl` to use.     | `1.30.0`      |
| `kubeconform_version` | Version of `kubeconform` to use. | `0.6.6`       |
| `kustomize_version`   | Version of `kustomize` to use.   | `5.4.1`       |
| `nushell_version`     | Version of `Nushell` to use.     | `0.93.0`      |
| `python_version`      | Version of `Python` to use.      | `3.12`        |

## Why Nushell?

Nushell is used in this action because of its ability to provide gorgeous, highly readable output. Its structured data model allows for elegant manipulation and presentation of Kubeconform's JSON results, making it much easier to interpret validation outcomes. This ensures that developers can quickly identify issues in their Kustomize projects and take necessary corrective actions.

## Credits

- **[Kubeconform](https://github.com/yannh/kubeconform):** For providing robust validation against Kubernetes schemas.
- **[yokawasa/action-setup-kube-tools](https://github.com/yokawasa/action-setup-kube-tools):** For simplifying the setup of Kubernetes tools like `kubectl`, `kubeconform`, and `kustomize`.
- **[Datree](https://github.com/datreeio/CRDs-catalog):** For their CRD Extractor tool and CRD schemas catalog.
- **[Nushell](https://github.com/nushell/nushell):** For providing a versatile shell that makes working with structured data seamless and intuitive.
- **[hustcer/setup-nu](https://github.com/hustcer/setup-nu):** For the GitHub Action that made setting up Nushell simple.

A huge thank you to these tools and their maintainers for helping make this validation action possible!

## License

This project is licensed under the [MIT License](LICENSE.md).
