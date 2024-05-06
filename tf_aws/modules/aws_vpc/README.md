<!-- BEGIN_TF_DOCS -->
# aws_vpc

This module will deploy a standard Parsons VPC.

The provider passed to the module will need to be assuming a role in the account where
you want SSM to be deployed.

Before this module was used, some customers referenced the CloudFormation stack outputs
to pull and use the VPC/subnets. Since a stack is no longer created and our state file's
outputs are not accessible outside of our team, we save some VPC details as SSM
parameters. This allows customers to continue to easily find and pull networking info
using the tool of their choice as long as they have the VPC name.

A variable number of SSM parameters will be created depending on how many VPCs and
subnets exist within each region.

| Name Format                                | Type       |
| -----------                                | ----       |
| /VPC/***VPC_NAME***/CIDR                   | String     |
| /VPC/***VPC_NAME***/EnvironmentTag         | String     |
| /VPC/***VPC_NAME***/ID                     | String     |
| /VPC/***VPC_NAME***/***SUBNET_NAME***/AZ   | String     |
| /VPC/***VPC_NAME***/***SUBNET_NAME***/CIDR | String     |
| /VPC/***VPC_NAME***/***SUBNET_NAME***/ID   | String     |
| /VPC/***VPC_NAME***/PrivateSubnetIDs       | StringList |
| /VPC/***VPC_NAME***/PrivateSubnetNames     | StringList |
| /VPC/***VPC_NAME***/S3EndpointID           | String     |

## Provider Requirements

This module expects a single, default provider which is assuming a role in the account
where you want the VPC deployed.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The IPv4 CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | DNS options which are used to create a DHCP options set and attach it to the VPC.<br>  If the object is null, the default DHCP option set is used. If domain\_name\_servers is<br>  omitted, AmazonProvidedDNS is used and resolver\_rule\_ids must be specified.<br>  resolver\_rule\_ids cannot be used with domain\_name\_servers. resolver\_rule\_ids should<br>  be a list of existing Route 53 Resolver Rules to associate to the VPC. | <pre>object({<br>    domain_name         = string<br>    domain_name_servers = optional(list(string), [])<br>    # Type = set so for_each can be used<br>    resolver_rule_ids = optional(set(string), [])<br>  })</pre> | `null` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | A boolean flag to enable/disable DNS hostnames in the VPC. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | A boolean flag to enable/disable DNS support in the VPC. | `bool` | `true` | no |
| <a name="input_flowlog_retention_days"></a> [flowlog\_retention\_days](#input\_flowlog\_retention\_days) | Retention in days for VPC flow logs | `number` | `30` | no |
| <a name="input_flowlog_traffic_type"></a> [flowlog\_traffic\_type](#input\_flowlog\_traffic\_type) | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL | `string` | `"ALL"` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC. Options are default or dedicated | `string` | `"default"` | no |
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | If the current AWS partition is GovCloud | `bool` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of private subnets to create in the VPC | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>  }))</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | The ID of the transit gateway to attach and route traffic to | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | VPC ID |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map of subnet keys and IDs |
| <a name="output_tgw_vpc_attachment_id"></a> [tgw\_vpc\_attachment\_id](#output\_tgw\_vpc\_attachment\_id) | The ID of the VPC's transit gateway attachment |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.cw_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_subscription_filter.cw_log_sub_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_flow_log.vpc_flowlog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.cw_log_sub_filter_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.flowlog_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_route53_resolver_config.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_config) | resource |
| [aws_route53_resolver_rule_association.forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_ssm_parameter.environment_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnet_names](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.s3_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.subnet_az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.subnet_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.subnet_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.dns_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.dns_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_availability_zones.allowed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.cw_log_sub_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flowlog_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_vpc_dhcp_options.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_dhcp_options) | data source |

## Examples

```hcl
# Example 1 - DMZ VPC using a DHCP option set and Route 53 resolver rules
vpcs_example_1 = {
  "vpc-dmz-parsons-com-sandbox-10-01" = {
    cidr_block = "192.168.12.128/25"
    dhcp_options = {
      domain_name       = "parsons.com"
      resolver_rule_ids = ["rslvr-rr-661623a5da542a5b5", "rslvr-rr-10fd4273e99f43d5b"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "192.168.12.128/26"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "192.168.12.192/26"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}

# Example 2 - DMZ VPC using a DHCP option set that uses Parsons DNS servers
vpcs_example_2 = {
  "vpc-dmz-parsons-com-sandbox-10-01" = {
    cidr_block = "192.168.12.128/25"
    dhcp_options = {
      domain_name         = "parsons.com"
      domain_name_servers = ["10.41.255.16", "10.41.255.76"]
    }
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "192.168.12.128/26"
      }
      "PrivateSubnet2A" = {
        availability_zone = "us-east-1b"
        cidr_block        = "192.168.12.192/26"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}

# Example 3 - DMZ VPC using Amazon Provided DNS
vpcs_example_3 = {
  "vpc-dmz-parsons-com-sandbox-10-01" = {
    cidr_block = "192.168.12.128/25"
    private_subnets = {
      "PrivateSubnet1A" = {
        availability_zone = "us-east-1a"
        cidr_block        = "192.168.12.128/26"
      }
    }
    transit_gateway_id = "tgw-0b54432052f2a35d7"
  }
}
```
<!-- END_TF_DOCS -->