<!-- BEGIN_TF_DOCS -->
# tf_aws

<!-- markdownlint-disable no-inline-html -->
<img src="https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg" alt="Terraform logo" height="50" />
&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://d0.awsstatic.com/logos/powered-by-aws.png" alt="Powered by AWS" height="50">

![Terraform Version](https://img.shields.io/badge/Terraform-%3E=1.5.0-7B42BC)
![terraform-aws](https://img.shields.io/badge/terraform--provider--aws-~%3E_5.0-FF9900)

[Terraform](https://www.terraform.io/) is a tool for building, changing, and versioning
infrastructure safely and efficiently. This repo is used in conjunction
with Terraform's [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
and the [tf_terragrunt](https://bitbucket.parsons.com/projects/CM/repos/tf_terragrunt) repo.

This repo contains reusable Terraform modules, while the Terragrunt repo contains
the variables used to define the resources deployed to the different environments.

Please see the following for more info, including install instructions and complete documentation:

* [Terraform/Terragrunt Usage at Parsons](https://confluence.parsons.com/display/IT/Terragrunt)
* [Terraform Website](https://www.terraform.io)
* [Terraform Documentation](https://www.terraform.io/docs/)
* [Terraform Tutorials](https://learn.hashicorp.com/terraform)
* [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Development Workflow

See
[tf_terragrunt](https://bitbucket.parsons.com/projects/CM/repos/tf_terragrunt/browse)
for more info.

1) Clone the repo to `C:\dev\code\cm\tf_aws`
1) Checkout `main` and `git pull` to make sure it's up to date
1) Create a new branch named after your Jira story number, e.g., `git checkout -b STAR-1234`
1) Commit changes and push your branch
1) Open a PR, ensure builds succeed
1) Merge once approved

## Documentation & Examples

This repo uses [terraform-docs](https://terraform-docs.io/) to help with documentation
generation for every module. The config file, `.terraform-docs.yaml`, specifies the
format of the generated README. This tool also forces documentation to be created for
each module. It runs automatically against every PR by the `Jenkinsfile` and will add a
commit to the PR with any changes. Each module's variables (inputs), outputs, and
resources are automatically added to the README in tabular format.

Every module, including the root module, should contain a
`docs` folder, which must contain `description.md` and `examples.txt`. The file
`description.md` should at least contain a H1 heading with the module name and a brief
description of the module. Since we use Bitbucket, make sure you follow their
[Markdown syntax guide](https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html).
`examples.txt` should contain at least 1 example of a root
module variable value which would be passed to the module. Since these modules are not
standalone and are only used in this repo by the root module, the only examples
provided help you learn how to use the module in the context of this repo.

> NOTE: Do not edit any `README.md` file manually or your changes will get overwritten!

## Linting, Formatting, & Best Practices

This repo uses [tflint](https://github.com/terraform-linters/tflint) and the plugin
[tflint-ruleset-aws](https://github.com/terraform-linters/tflint-ruleset-aws) to find
possible errors, warn about deprecated syntax and unused declarations, and enforce
best practices. The `Jenkinsfile` in the root of this repo runs automatically against
every PR and will cause the PR's build to fail if there are any findings. Formatting is
handled by the Terraform CLI and any changes will be committed and pushed to the PR's
dev branch. We attempt to follow the best practices outlined in Google's
[Best practices for using Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_details"></a> [account\_details](#input\_account\_details) | Details of the account to create | <pre>object({<br>    additional_alternate_contacts = optional(map(object({<br>      alternate_contact_type = string<br>      title                  = string<br>      email_address          = string<br>      phone_number           = string<br>    })), {})<br>    additional_sso_assignments = optional(map(object({<br>      instance_arn       = string<br>      target_type        = string<br>      permission_set_arn = string<br>      principal_type     = string<br>      principal_id       = string<br>    })), {})<br>    admin_role_name = optional(string, "OrganizationAccountAccessRole")<br>    # Only use on a Commercial account to create a linked GovCloud account<br>    # Cannot be changed after initial creation<br>    create_govcloud = optional(bool, false)<br>    email_address   = string<br>    name            = string<br>    parent_ou_id    = optional(string)<br>    # These optional tags will override provider defaults<br>    tags = optional(map(string), {})<br>  })</pre> | `null` | no |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Account ID of an existing account to create resources in | `string` | `null` | no |
| <a name="input_common_account_contacts"></a> [common\_account\_contacts](#input\_common\_account\_contacts) | Map of objects for common account alternate contacts | <pre>map(object({<br>    alternate_contact_type = string<br>    title                  = string<br>    email_address          = string<br>    phone_number           = string<br>  }))</pre> | `{}` | no |
| <a name="input_common_account_sso_assignments"></a> [common\_account\_sso\_assignments](#input\_common\_account\_sso\_assignments) | Map of objects for common account SSO assignments | <pre>map(object({<br>    instance_arn       = string<br>    target_type        = string<br>    permission_set_arn = string<br>    principal_type     = string<br>    principal_id       = string<br>  }))</pre> | `{}` | no |
| <a name="input_customer_gateways"></a> [customer\_gateways](#input\_customer\_gateways) | value | <pre>map(object({<br>    bgp_asn    = number<br>    ip_address = string<br>    tags       = optional(map(string), {})<br>    vpn_connections = map(object({<br>      transit_gateway_key = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Required default AWS tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_deploy_parsons_us_saml_idp"></a> [deploy\_parsons\_us\_saml\_idp](#input\_deploy\_parsons\_us\_saml\_idp) | If a SAML IdP should be deployed for parsons.us users to access the account, set this<br>value to a set of strings to define which roles should be configured. See the module<br>for more info about what roles are supported. | `set(string)` | `null` | no |
| <a name="input_deploy_ssm"></a> [deploy\_ssm](#input\_deploy\_ssm) | Whether to deploy SSM managed support in the account. | `bool` | `false` | no |
| <a name="input_iam_groups"></a> [iam\_groups](#input\_iam\_groups) | A collection of IAM groups to create | <pre>map(object({<br>    path        = optional(string, "/")<br>    policy_keys = set(string)<br>  }))</pre> | `{}` | no |
| <a name="input_iam_policies"></a> [iam\_policies](#input\_iam\_policies) | A collection of IAM policies to create | <pre>map(object({<br>    description = optional(string)<br>    name_prefix = optional(string)<br>    path        = optional(string, "/")<br>    policy_hcl = optional(object({<br>      statements = map(object({<br>        actions   = optional(list(string))<br>        effect    = string<br>        resources = list(string)<br>        sid       = optional(string)<br>      }))<br>      version = optional(string, "2012-10-17")<br>    }))<br>    policy_yaml = optional(string)<br>    tags        = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_iam_users"></a> [iam\_users](#input\_iam\_users) | A collection of IAM users to create | <pre>map(object({<br>    access_keys = optional(map(object({<br>      auto_rotate_days = optional(number)<br>      staggered_rotation = optional(object({<br>        overlap_days = optional(number, 10)<br>        rotate_days  = number<br>      }))<br>      status = optional(string, "Active")<br>      vault = optional(object({<br>        mount = string<br>        path  = string<br>      }))<br>    })), {})<br>    group_keys = set(string)<br>    path       = optional(string, "/")<br>    tags       = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | Map of objects used to create load balancers | <pre>map(object({<br>    external_tls_decryption        = optional(bool, false)<br>    alb_fips                       = optional(bool, false)<br>    alb_drop_invalid_header_fields = optional(bool, true)<br>    certificates = optional(map(object({<br>      # Map key = domain name<br>      subject_alternative_names = optional(list(string), [])<br>    })), {})<br>    deletion_protection    = optional(bool, true)<br>    deregistration_delay   = optional(number, 300)<br>    desync_mitigation_mode = optional(string, "defensive")<br>    idle_timeout           = optional(number, 60)<br>    internal               = bool<br>    listeners = map(object({<br>      default_cert_key    = optional(string)<br>      port                = number<br>      protocol            = string<br>      secondary_cert_keys = optional(list(string), [])<br>      default_action = object({<br>        fixed_response = optional(object({<br>          content_type = string<br>          message_body = optional(string)<br>          status_code  = optional(string)<br>        }))<br>        forward = optional(object({<br>          target_groups = map(object({<br>            key    = string<br>            weight = optional(number)<br>          }))<br>          stickiness = optional(object({<br>            enabled  = bool<br>            duration = optional(number)<br>          }))<br>        }))<br>        redirect = optional(object({<br>          host        = optional(string)<br>          path        = optional(string)<br>          port        = optional(string)<br>          protocol    = optional(string)<br>          query       = optional(string)<br>          status_code = string<br>        }))<br>        type             = string<br>        target_group_key = optional(string)<br>      })<br>      rules = optional(map(object({<br>        action = object({<br>          fixed_response = optional(object({<br>            content_type = string<br>            message_body = optional(string)<br>            status_code  = optional(string)<br>          }))<br>          forward = optional(object({<br>            target_groups = map(object({<br>              key    = string<br>              weight = optional(number)<br>            }))<br>            stickiness = optional(object({<br>              enabled  = bool<br>              duration = optional(number)<br>            }))<br>          }))<br>          redirect = optional(object({<br>            host        = optional(string)<br>            path        = optional(string)<br>            port        = optional(string)<br>            protocol    = optional(string)<br>            query       = optional(string)<br>            status_code = string<br>          }))<br>          type             = string<br>          target_group_key = optional(string)<br>        })<br>        conditions = map(object({<br>          host_header = optional(list(string))<br>          http_header = optional(object({<br>            http_header_name = string<br>            values           = list(string)<br>          }))<br>          http_request_method = optional(list(string))<br>          path_pattern        = optional(list(string))<br>          query_string = optional(map(object({<br>            key   = string<br>            value = string<br>          })))<br>          source_ip = optional(list(string))<br>        }))<br>        priority = optional(number)<br>      })), {})<br>    }))<br>    nlb_dns_record_client_routing_policy = optional(string, "any_availability_zone")<br>    nlb_network_cross_zone               = optional(bool, false)<br>    redirect_80_to_443                   = bool<br>    # Not to be used together. Only specify subnet_id if the VPC isn't managed by Terraform<br>    # subnet_keys must be used with vpc_key<br>    subnet_ids  = optional(list(string))<br>    subnet_keys = optional(list(string))<br>    tags        = optional(map(string))<br>    # Must start with "tg-". Max of 26 characters total. Port will be auto-appended<br>    target_groups = map(object({<br>      health_check = object({<br>        path     = optional(string)<br>        port     = number<br>        protocol = string<br>        matcher  = optional(string, "200")<br>      })<br>      nlb_connection_termination      = optional(bool, false)<br>      alb_target_for_port_80_listener = optional(bool, false)<br>      nlb_preserve_client_ip          = optional(bool)<br>      nlb_targets_outside_vpc         = optional(bool, false)<br>      port                            = number<br>      protocol                        = string<br>      stickiness = optional(object({<br>        cookie_duration = optional(number, 86400)<br>        cookie_name     = optional(string)<br>        enabled         = optional(bool, true)<br>        type            = string<br>      }))<br>      targets = set(string)<br>      type    = string<br>    }))<br>    type = string<br>    # Not to be used together. Only specify vpc_id if the VPC isn't managed by Terraform<br>    # vpc_key must be used with subnet_keys<br>    vpc_id  = optional(string)<br>    vpc_key = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_management_account_role"></a> [management\_account\_role](#input\_management\_account\_role) | The org management role to assume when creating the AWS account | `string` | n/a | yes |
| <a name="input_network_account_id"></a> [network\_account\_id](#input\_network\_account\_id) | The network account ID in the org | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Object to create the AWS Organization | <pre>object({<br>    aws_service_access_principals = optional(list(string))<br>    feature_set                   = optional(string, "ALL")<br>    enabled_policy_types          = optional(list(string))<br>    policies = map(object({<br>      description = string<br>      content     = string<br>      type        = optional(string, "SERVICE_CONTROL_POLICY")<br>      targets     = optional(list(string), [])<br>    }))<br>    organizational_units = map(any)<br>    tags                 = optional(map(string))<br>  })</pre> | `null` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | The AWS profile to use | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_root_ou"></a> [root\_ou](#input\_root\_ou) | This is only used by a Python script, but is here to suppress a warning. | `string` | `null` | no |
| <a name="input_sso_region"></a> [sso\_region](#input\_sso\_region) | The region where SSO resides, as SSO assignments will be created | `string` | n/a | yes |
| <a name="input_tgw_route_tables"></a> [tgw\_route\_tables](#input\_tgw\_route\_tables) | A map of transit gateway route table objects. To create an empty, central route table<br>for a transit gateway, only specify `transit_gateway_id`. For a route table for a<br>DMZ VPC, specify `vpc_keys` and the optional blackhole override. | <pre>map(object({<br>    override_blackhole_cidrs = optional(set(string))<br>    tags                     = optional(map(string))<br>    transit_gateway_key      = optional(string)<br>    vpc_keys                 = optional(list(string), [])<br>  }))</pre> | `{}` | no |
| <a name="input_transit_gateways"></a> [transit\_gateways](#input\_transit\_gateways) | A map of transit gateway objects to create | <pre>map(object({<br>    amazon_side_asn                 = optional(number, 64512)<br>    auto_accept_shared_attachments  = optional(bool, false)<br>    cidr_blocks                     = optional(list(string))<br>    default_route_table_association = optional(bool, false)<br>    default_route_table_propagation = optional(bool, false)<br>    description                     = string<br>    dns_support                     = optional(bool, true)<br>    share_to_principals             = optional(set(string), [])<br>    tags                            = optional(map(string), {})<br>    vpn_ecmp_support                = optional(bool, true)<br>  }))</pre> | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | The username of the person running Terraform in Vagrant, or 'jenkins' | `string` | n/a | yes |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | Map of objects used to create VPCs | <pre>map(object({<br>    cidr_block = string<br>    dhcp_options = optional(object({<br>      domain_name         = string<br>      domain_name_servers = optional(list(string), [])<br>      # Type = set so for_each can be used<br>      resolver_rule_ids = optional(set(string), [])<br>    }))<br>    enable_dns_hostnames   = optional(bool, true)<br>    enable_dns_support     = optional(bool, true)<br>    flowlog_retention_days = optional(number, 30)<br>    flowlog_traffic_type   = optional(string, "ALL")<br>    instance_tenancy       = optional(string, "default")<br>    tags                   = optional(map(string))<br>    transit_gateway_id     = string<br>    private_subnets = map(object({<br>      availability_zone = string<br>      cidr_block        = string<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | The ID of the AWS account being managed |
| <a name="output_current_partition"></a> [current\_partition](#output\_current\_partition) | The current AWS partition |
| <a name="output_current_region"></a> [current\_region](#output\_current\_region) | The current AWS region |
| <a name="output_customer_gateways"></a> [customer\_gateways](#output\_customer\_gateways) | A map of all customer gatweays and their outputs |
| <a name="output_govcloud_account_id"></a> [govcloud\_account\_id](#output\_govcloud\_account\_id) | The ID of the AWS GovCloud account that was created |
| <a name="output_iam_groups"></a> [iam\_groups](#output\_iam\_groups) | A map of all IAM groups and their outputs |
| <a name="output_iam_policies"></a> [iam\_policies](#output\_iam\_policies) | A map of all IAM policies and their outputs |
| <a name="output_iam_user_access_keys"></a> [iam\_user\_access\_keys](#output\_iam\_user\_access\_keys) | A map of each IAM user and its access keys |
| <a name="output_iam_users"></a> [iam\_users](#output\_iam\_users) | A map of all IAM users and their outputs |
| <a name="output_load_balancers"></a> [load\_balancers](#output\_load\_balancers) | A map of all load balancers and their outputs |
| <a name="output_parsons_us_saml_okta_group_names"></a> [parsons\_us\_saml\_okta\_group\_names](#output\_parsons\_us\_saml\_okta\_group\_names) | What the name(s) of the Okta group(s) should be for parsons.us SAML setup |
| <a name="output_transit_gateway_route_tables"></a> [transit\_gateway\_route\_tables](#output\_transit\_gateway\_route\_tables) | A map of all transit gateway route tables and their outputs |
| <a name="output_transit_gateways"></a> [transit\_gateways](#output\_transit\_gateways) | A map of all transit gateways and their outputs |
| <a name="output_vpcs"></a> [vpcs](#output\_vpcs) | A map of all VPCs and their outputs |

## Resources

| Name | Type |
|------|------|
| [null_resource.account_variable_validation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.org_master_account_validation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.tgw_rt_variable_validation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Examples

```hcl
# N/A
```
<!-- END_TF_DOCS -->