<!-- BEGIN_TF_DOCS -->
# Fortigate Policy configuration module

This terraform module configures Policy on a firewall

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_fortios"></a> [fortios](#provider\_fortios) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [fortios_firewall_policy.policy](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/resources/firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_path"></a> [config\_path](#input\_config\_path) | Path to base configuration directory | `string` | n/a | yes |
| <a name="input_vdoms"></a> [vdoms](#input\_vdoms) | List of VDOMs from which to pull in configuration | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->