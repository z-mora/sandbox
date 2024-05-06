<!-- BEGIN_TF_DOCS -->
# aws_parsons_us_saml_idp

This module performs the setup required to allow parsons.us users to access an AWS
account via login.parsons.us. This will work in either a Commerical or GovCloud account.
It's intended to be deployed in the same Terragrunt module as the account deployment.

For more info about this setup, see
[AWS SAML setup for .us users](https://confluence.parsons.com/display/IT/AWS+SAML+setup+for+.us+users)

There is an output that provides you with the name(s) of the Okta group(s) you will need
to create and add the users to.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The ID of the account where the IdP and role will be deployed | `string` | n/a | yes |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | The name of the account to add as a prefix to the role name. For example, if<br>the account name is is "pce-fed-mtc-epoch1-dev", the role name would be<br>`pce-fed-mtc-epoch1-dev-ADMIN-Role` | `string` | n/a | yes |
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | If the current account is in gov or not | `bool` | n/a | yes |
| <a name="input_partition"></a> [partition](#input\_partition) | The current AWS partition | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | The roles & policies that will be created for the parons.us users to use.<br>`account-admin` is typically what's provided to users.<br>`full_admin` may be required in some exceptions, which allows everything.<br>`billing` only allows billing & support related actions, which is likely only necessary<br>if granting access to a GovCloud parent account. | `set(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_okta_group_names"></a> [okta\_group\_names](#output\_okta\_group\_names) | What the name of the Okta group should be for parsons.us SAML setup |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_saml_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |

## Examples

```hcl
# Example 1 - Deploy the admin role
deploy_parsons_us_saml_idp = ["account-admin"]

# Example 2 - Deploy the billing role
deploy_parsons_us_saml_idp = ["billing"]

# Example 3 - Deploy the full_admin role
deploy_parsons_us_saml_idp = ["full-admin"]

# Example 4 - Deploy the route53_parsons_cyber role
deploy_parsons_us_saml_idp = ["route53-parsons-cyber"]

# Example 5 - Deploy the route53_parsons_games role
deploy_parsons_us_saml_idp = ["route53-parsons-games"]

# Example 6 - Deploy multiple roles
deploy_parsons_us_saml_idp = ["account-admin", "full-admin", "billing"]
```
<!-- END_TF_DOCS -->