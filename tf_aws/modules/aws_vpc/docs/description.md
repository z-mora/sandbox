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
