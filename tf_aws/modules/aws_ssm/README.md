<!-- BEGIN_TF_DOCS -->
# aws_ssm

This module will build a standard Parsons SSM deployment for automated patch management
and SOC tools installation. For more information see
[this](https://confluence.parsons.com/pages/viewpage.action?pageId=246285338)
Confluence page.

The provider passed to the module will need to be assuming a role in the account
where you want SSM to be deployed.

These tags are set for all SSM resources in every account:

| Tag | Value |
|---|---|
| GBU | COR |
| ITSM | MANAGEMENT |
| Job/Wbs | 897720-01101 |
| Owner | infraopscloud@parsons.com |

You must ensure that you're not setting the same tag key/value as a default tag
and in the SSM module. If you do, Terraform will attempt to set the tag on every run
without making any changes. There's a local in the root module, `ssm_tags` that
addresses this for you by skipping any SSM tags that happen to be the same as a default
tag.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the account
that will be utilizing SSM.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | If the current AWS partition is Gov | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_ssm_association.security_tool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_association) | resource |
| [aws_ssm_association.software_inventory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_association) | resource |
| [aws_ssm_association.stig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_association) | resource |
| [aws_ssm_document.apply_ansible_playbooks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [aws_ssm_maintenance_window.patching](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window_target.patching](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_task.patching](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_resource_data_sync.inventory_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_resource_data_sync) | resource |

## Examples

```hcl
# Example 1
deploy_ssm = true
```
<!-- END_TF_DOCS -->