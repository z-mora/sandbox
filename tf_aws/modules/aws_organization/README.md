<!-- BEGIN_TF_DOCS -->
# aws_organization

This module allows the creation of an AWS organization and management of organization policies and OUs.

## Provider Requirements

This module requires one provider:

1) A default provider which is assuming a role in the org master account where the organization is managed

## Organization Policy Map

The policy map contains each policy as a separate object. Each policy must contain a description of the policy
and a content string. The content string should be a multi-line string containing the json formatted policy rule.

Note: AWS managed policies cannot be managed by Terraform. They use a different form of ID (simply the policy name),
and when used terraform throws an invalid ID error.

## OU map

Since OUs can be nested within each other, that nested configuration must be reconsituted here. Each OU name should
be a key to its own map nested under its parent ou. The Root OU is not managed itself, but its policies are, so it should always
be represented in this map as the highest tier and have the key "Root".

If an OU has policies attached to it they are assigned by a list of strings called policies. Each string should match
a policy listed in the policies map within the organization map. This assigns the matching policy to the OU.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | List of AWS service principal names for which we want to enable integration | `list(string)` | n/a | yes |
| <a name="input_enabled_policy_types"></a> [enabled\_policy\_types](#input\_enabled\_policy\_types) | List of organizations policy types to enable in root | `list(string)` | n/a | yes |
| <a name="input_feature_set"></a> [feature\_set](#input\_feature\_set) | Specify 'ALL' (default) or 'CONSOLIDATED\_BILLING' | `string` | `"ALL"` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | Map of OUs with the name of parent in each object | `map(any)` | `{}` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | map of policies. Each object is a policy with description and content strings | <pre>map(object({<br>    description = string<br>    content     = string<br>    type        = optional(string, "SERVICE_CONTROL_POLICY")<br>    targets     = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.level_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.level_3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.level_4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |

## Examples

```hcl
#  Example  1 - Commercial Corporate Organization
organization = {
  aws_service_access_principals = [
    "access-analyzer.amazonaws.com",
    "account.amazonaws.com",
    "aws-artifact-account-sync.amazonaws.com",
    "backup.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "compute-optimizer.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
    "config.amazonaws.com",
    "fms.amazonaws.com",
    "guardduty.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com",
    "ram.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com",
    "securityhub.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "ssm.amazonaws.com",
    "sso.amazonaws.com",
    "tagpolicies.tag.amazonaws.com"
  ]
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "BACKUP_POLICY",
    "TAG_POLICY"
  ]

  organizational_units = {
     "Root" = {
      policies = [
        "organizations_restrict",
        "restrict_lambda_vpc_use"
      ]
      "Exceptions" = {
        "ExceptionAccounts" = {}
      }
      "Infrastructure" = {
        policies = [
          "restrict_regions",
          "restrict_root",
          "security_services_baseline"
        ]
        "Backup" = {
          "MEA" = {}
        }
        "NetworkProd" = {
          policies = [
            "network_account"
          ]
          "ca-central-1" = {}
          "MEA"          = {}
        }
        "NetworkTest" = {
          policies = [
            "network_account"
          ]
        }
        "SharedServicesProd" = {}
        "SharedServicesTest" = {}
      }
      "PolicyStaging" = {
        "Infrastructure" = {
          policies = [
            "network_account"
          ]
        }
        "Sandbox" = {
          policies = [
            "restrict_regions",
            "restrict_root",
            "security_services_baseline"
          ]
        }
        "Security" = {
          policies = [
            "restrict_regions",
            "restrict_root",
            "security_services_baseline"
          ]
        }
        "Workload" = {
          policies = [
            "restrict_regions",
            "restrict_root",
            "security_services_baseline"
          ]
        }
      }
      "Sandbox" = {
        policies = [
          "restrict_regions",
          "restrict_root",
          "security_services_baseline"
        ]
        "Demo" = {}
        "Dev"  = {}
      }
      "Security" = {
        policies = [
          "restrict_regions",
          "restrict_root",
          "security_services_baseline"
        ]
        "Prod" = {
          "MEA" = {}
        }
        "Test" = {}
      }
      "ServiceCatalog" = {
        "Prod" = {}
        "Test" = {}
      }
      "Suspended" = {
      }
      "Workload" = {
        policies = [
          "restrict_regions",
          "restrict_root",
          "security_services_baseline"
        ]
        "Prod" = {
          "ca-central-1" = {}
          "MEA"          = {}
        }
        "SDLC" = {
          "MEA" = {}
        }
      }
    }
  }
  
  organization_policies = {
    "backup_account" = {
      description = "This SCP blocks unnecessary services that are not used in the Backup accounts."
    }
    "logging_account" = {
      description = "This SCP blocks unnecessary services that are not used in the centralized Logging accounts"
    }
    "network_account" = {
      description = "This SCP blocks unnecessary services that are not used in the centralized Network accounts - needed services include Transit Gateways, VPN Tunnels, Palo Altos, Cisco SD-WAN, Direct Connect, Global Accelerator, NLB/ALB, CloudFront."
    }
    "organizations_restrict" = {
      description = "-"
    }
    "restrict_lambda_vpc_use" = {
      description = "Do not let the use of Lambda Shared VPC unless by automation"
    }
    "restrict_regions" = {
      description = "-"
    }
    "restrict_root" = {
      description = "-"
    }
    "security_services_baseline" = {
      description = "-"
    }
    "suspend_account" = {
      description = "This SCP blocks all access other than to the Billing and Cost Explorer consoles."
    }
  }
}

# Example 2 - Organization with feature_set set to "CONSOLIDATED_BILLING"
organization = {
  aws_service_access_principals = [
    "access-analyzer.amazonaws.com",
    "account.amazonaws.com",
    "aws-artifact-account-sync.amazonaws.com",
    "backup.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "compute-optimizer.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
    "config.amazonaws.com",
    "fms.amazonaws.com",
    "guardduty.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com",
    "ram.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com",
    "securityhub.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "ssm.amazonaws.com",
    "sso.amazonaws.com",
    "tagpolicies.tag.amazonaws.com"
  ]
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "BACKUP_POLICY",
    "TAG_POLICY"
  ]
  feature_set =  "CONSOLIDATED_BILLING"

  organizational_units = {
    "Root" = {
      policies = [
        "example_policy"
      ]
      "Infrastructure" = {
        policies = [
          "example_policy"
        ]
        "Backup" = {
          "MEA" = {}
        }
        "NetworkProd" = {
          "ca-central-1" = {}
          "MEA"          = {}
        }
        "NetworkTest"        = {}
        "SharedServicesProd" = {}
        "SharedServicesTest" = {}
      }
    }
  }

  organization_policies = {
    "example_policy" = {
      description = "example description"
      content     = <<CONTENT
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Deny",
              "Action": "organizations:LeaveOrganization",
              "Resource": "*"
            }
          ]
        }
      CONTENT
    }
  }
}
```
<!-- END_TF_DOCS -->