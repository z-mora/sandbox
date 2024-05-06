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
