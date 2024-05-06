<!-- BEGIN_TF_DOCS -->
# aws_iam_policy

This module will allow you to deploy an IAM policy using either HCL or YAML. HCL is the
preferred approach, but YAML is available as an option since most of our policies are
already in YAML.

## Variables & Pseudo Parameters

Unfortunately, tfvars are constants and don't support referencing other variables,
locals, data sources, etc. Tfvars don't support string interpolation. You can use
[string templates](https://developer.hashicorp.com/terraform/language/expressions/strings#string-templates),
but they don't work with the AWS pseudo parameters because they contain a double colon.
To continue to allow dynamic templates, we use the
[replace](https://developer.hashicorp.com/terraform/language/functions/replace) function
to replace the supported pseudo parameters (below) with their dynamic value.

Since we already use CloudFormation psuedo parameters in our YAML templates, this
module uses the same approach for policies defined in HCL. The only thing you have to
adjust in your templates is the quoting of `$`. You can do a search and replace to find
all instances of `${` and replace it with `$${`. This will cause Terraform to
treat the `${` as literal characters instead of attempting to substitute a variable,
which will throw an error since it's not supported in tfvars. This module also removes
`!Sub` from policies.

| Pseudo Parameter      | Supported |
|-----------------------|-----------|
| AWS::AccountId        | ✔️        |
| AWS::NotificationARNs | ❌        |
| AWS::NoValue          | ✔️        |
| AWS::Partition        | ✔️        |
| AWS::Region           | ✔️        |
| AWS::StackId          | ❌        |
| AWS::StackName        | ❌        |
| AWS::URLSuffix        | ❌        |

This module also supports
[AWS policy variables](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html).
As long as the variables have `$` escaped, they will not be removed or altered.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
current account.

## Additional Info

* [IAM policy elements: Variables and tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html)
* [Pseudo parameters reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/pseudo-parameter-reference.html)
* [String templates](https://developer.hashicorp.com/terraform/language/expressions/strings#string-templates)
* [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
* [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)
* [replace](https://developer.hashicorp.com/terraform/language/functions/replace)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_current_account_id"></a> [current\_account\_id](#input\_current\_account\_id) | The current account ID. Used to replace CloudFormation pseudo params | `string` | n/a | yes |
| <a name="input_current_partition"></a> [current\_partition](#input\_current\_partition) | The current AWS partition. Used to replace CloudFormation pseudo params | `string` | n/a | yes |
| <a name="input_current_region"></a> [current\_region](#input\_current\_region) | The current AWS region. Used to replace CloudFormation pseudo params | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy. If changed, will force recreation of the policy. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy. If changed, will force recreation of the policy. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Creates a unique name for the policy beginning with the specified prefix.<br>If specified, will be used instead of `name`. If changed, will force recreation of the<br>policy. | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the policy. | `string` | `"/"` | no |
| <a name="input_policy_hcl"></a> [policy\_hcl](#input\_policy\_hcl) | The policy document, defined in HCL. Any `$` characters in the policy need to be<br>escaped with another `$`. See README for info about CloudFormation psuedo params. | <pre>object({<br>    statements = map(object({<br>      actions   = optional(list(string))<br>      effect    = string<br>      resources = list(string)<br>      sid       = optional(string)<br>    }))<br>    version = optional(string, "2012-10-17")<br>  })</pre> | `null` | no |
| <a name="input_policy_yaml"></a> [policy\_yaml](#input\_policy\_yaml) | The policy document as a YAML string. This isn't the recommended approach. Any `$`<br>characters in the policy need to be escaped with another `$`. See README for info<br>about CloudFormation pseudo params. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the policy that was created |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy that was created. This will differ from the policy key if a<br>`name_prefix` was provided. |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.from_hcl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.from_yaml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Examples

```hcl
# Example 1 - Policy defined using HCL (Note that $ is escaped)
iam_policies = {
  "policy-test-terragrunt-admin" = {
    description = "Policy Assume Role for Terragrunt Admin Plan and Apply"
    policy_hcl = {
      version = "2012-10-17"
      statements = {
        "AllowAssumeOfTerragruntRole" = {
          actions = ["sts:AssumeRole"]
          effect  = "Allow"
          resources = [
            "arn:$${AWS::Partition}:iam::*:role/service-role/_sys_terragrunt_admin_role"
          ]
        }
        "AllowPlanningNewAccounts" = {
          actions   = ["ec2:DescribeAvailabilityZones", "sts:GetCallerIdentity"]
          effect    = "Allow"
          resources = ["*"]
        }
      }
    }
  }
}

# Example 2 - Policy defined using YAML (Note that $ is escaped)
iam_policies = {
  "policy-test-terragrunt-admin" = {
    description = "Policy Assume Role for Terragrunt Admin Plan and Apply"
    policy_yaml = <<-EOF
      Version: 2012-10-17
      Statement:
      - Effect: Allow
        Sid: "AllowAssumeOfTerragruntRole"
        Action:
          - "sts:AssumeRole"
        Resource: !Sub "arn:$${AWS::Partition}:iam::*:role/service-role/_sys_terragrunt_admin_role"
      - Effect: Allow
        Sid: "AllowPlanningNewAccounts"
        Action:
          - "ec2:DescribeAvailabilityZones"
          - "sts:GetCallerIdentity"
        Resource: "*"
    EOF
  }
}
```
<!-- END_TF_DOCS -->