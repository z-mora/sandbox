<!-- BEGIN_TF_DOCS -->
# aws_account

This module will create a new account (either Commercial or GovCloud) with contacts and
SSO assignments.

The provider passed to the module will need to be assuming a role in the org master
where you want to create the account.

NOTE: Corporate accounts (except for network accounts) will always have their `Job/Wbs`
tag set to an empty string, per FinOps.

## GovCloud

`create_govcloud` can only be set to true when creating a new account, not afterwards.
You cannot create a GovCloud account on an account that already exists. If you create a
GovCloud account, you will end up with two accounts:

- A parent account in the Commercial partition where billing is handled
- A child account in the GovCloud partition which is linked to the parent. This is where
you will deploy resources

Unfortunately, when Terraform creates a GovCloud account it doesn't get added to the
state file or an organization. Only the Commerical parent will be in the state. You will
need an external process to import the GovCloud child account into the state file to
have it managed by Terraform and add it to an organization.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's management account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_alternate_contacts"></a> [additional\_alternate\_contacts](#input\_additional\_alternate\_contacts) | Map of objects for account additional alternate contacts | <pre>map(object({<br>    alternate_contact_type = string<br>    title                  = string<br>    email_address          = string<br>    phone_number           = string<br>  }))</pre> | `{}` | no |
| <a name="input_additional_sso_assignments"></a> [additional\_sso\_assignments](#input\_additional\_sso\_assignments) | Map of objects for additional account assignments that are optional | <pre>map(object({<br>    instance_arn       = string<br>    target_type        = string<br>    permission_set_arn = string<br>    principal_type     = string<br>    principal_id       = string<br>  }))</pre> | `{}` | no |
| <a name="input_admin_role_name"></a> [admin\_role\_name](#input\_admin\_role\_name) | The name of an IAM role that Organizations automatically preconfigures in the new<br>member account. This role trusts the root account, allowing users in the root<br>account to assume the role, as permitted by the root account administrator. The role<br>has administrator permissions in the new member account. | `string` | n/a | yes |
| <a name="input_common_alternate_contacts"></a> [common\_alternate\_contacts](#input\_common\_alternate\_contacts) | Map of objects for common account alternate contacts | <pre>map(object({<br>    alternate_contact_type = string<br>    title                  = string<br>    email_address          = string<br>    phone_number           = string<br>  }))</pre> | `{}` | no |
| <a name="input_common_sso_assignments"></a> [common\_sso\_assignments](#input\_common\_sso\_assignments) | Map of objects for common account assignments for all accounts | <pre>map(object({<br>    instance_arn       = string<br>    target_type        = string<br>    permission_set_arn = string<br>    principal_type     = string<br>    principal_id       = string<br>  }))</pre> | `{}` | no |
| <a name="input_create_govcloud"></a> [create\_govcloud](#input\_create\_govcloud) | Also creates a GovCloud account if true | `bool` | `false` | no |
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | AWS Account Email Address | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the AWS account | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The ID of the current organization | `string` | n/a | yes |
| <a name="input_parent_ou_id"></a> [parent\_ou\_id](#input\_parent\_ou\_id) | AWS Parent OU ID, this should be null for the org master account. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_govcloud_account_id"></a> [govcloud\_account\_id](#output\_govcloud\_account\_id) | The ID of the AWS GovCloud account that was created |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AWS account being managed |
| <a name="output_name"></a> [name](#output\_name) | The name of the AWS account that was created |

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.common](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_ssoadmin_account_assignment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_account_assignment.common](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |

## Examples

```hcl
# Example 1 - regular Commercial account
account_details = {
  additional_sso_assignments = {
    "SRE-Role" = {
      instance_arn          = "arn:aws:sso:::instance/ssoins-7223ac947bcac0c1"
      target_type        = "AWS_ACCOUNT"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223ac947bcac0c1/ps-a98f0c48a7aad88e"
      principal_type  = "GROUP"
      principal_id       = "906708fe40-c2c8cbcb-ddeb-49a3-916c-2982df4c25b8"
    }
  }
  additional_alternate_contacts = {
    "ServerManagement" = {
      alternate_contact_type = "OPERATIONS"
      title                  = "ServerManagement"
      email_address          = "servermanagement@parsons.com"
      phone_number           = "800-252-8108"
    }
  }
  email_address = "aws+test310@gotnetwork.com"
  name          = "oce-infraops-sandbox-10"
  parent_ou_id  = "ou-gvmm-yaxwtbvy"
}

# Example 2 - a GovCloud parent and child
account_details = {
  account_name = "pce-infraops-sandbox-03"
  additional_alternate_contacts = {
    "InfraOpsCloud" = {
      alternate_contact_type = "OPERATIONS"
      email_address          = "infraopscloud@parsons.com"
      phone_number           = "800-252-8108"
      title                  = "InfraOpsCloud"
    }
  }
  common_alternate_contacts = {
    "CyberRespond" = {
      alternate_contact_type = "SECURITY"
      email_address          = "cyberrespond@parsons.com"
      phone_number           = "800-252-8108"
      title                  = "CyberRespond"
    }
  }
  common_sso_assignments = {
    "ADMIN-Role" = {
      instance_arn       = "arn:aws:sso:::instance/ssoins-7223b8bca6133ba8"
      permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-7223b8bca6133ba8/ps-073f4548cf815e72"
      principal_id       = "9067615d55-991027f4-e454-47f4-9145-e20486b3e81e"
      principal_type     = "GROUP"
      target_type        = "AWS_ACCOUNT"
    }
  }
  create_govcloud = true
  email_address   = "aws+test+pce+03@gotnetwork.com"
  parent_ou_id    = "ou-04fu-p6jutvut"
}
```
<!-- END_TF_DOCS -->