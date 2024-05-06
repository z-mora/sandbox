<!-- BEGIN_TF_DOCS -->
# aws_iam_group

This module will allow you to deploy an IAM group with 1 or more policies attached.

We use groups to assign policies to users, even if it's just a single user in the group.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
current account.

## Additional Info

* [12 AWS IAM Security Best Practices - #2 Attach Permissions to Groups Instead of Individual Users](https://spacelift.io/blog/aws-iam-best-practices#2-attach-permissions-to-groups-instead-of-individual-users)
* [aws_iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)
* [aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The group's name. The name must consist of upper and lowercase alphanumeric characters<br>with no spaces. You can also include any of the following characters: =,.@-\_..<br>Group names are not distinguished by case. For example, you cannot create groups named<br>both "ADMINS" and "admins". | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the group. | `string` | `"/"` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | A map of policies to attach to the group. The key is the key of the policy and the<br>value is the ARN. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the group that was created |
| <a name="output_id"></a> [id](#output\_id) | The ID of the group that was created |
| <a name="output_name"></a> [name](#output\_name) | The name of the group that was created |

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |

## Examples

```hcl
# Example 1 - Group with a single policy attached
iam_groups = {
  group-test-terragrunt-admin = {
    policy_keys = ["policy-test-terragrunt-admin"]
  }
}

# Example 2 - Group with two policies attached
iam_groups = {
  group-test-terragrunt-admin = {
    policy_keys = [
      "policy-test-1",
      "policy-test-2"
    ]
  }
}
```
<!-- END_TF_DOCS -->