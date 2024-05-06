# aws_tgw

This module allows you to deploy a transit gateway. You can also optionally share the
transit gateway with a list of principals.

Corporate TGW's should have a default route table configured for association and
propagation, as the VPC's that get associated aren't isolated and share a route table.
TGW's in non-corp orgs shouldn't have a default route table configured, as the VPC's
that get associated in these orgs are isolated and will each have their own route table
to accomplish that.

> NOTE: As of hashicorp/aws v5.11.0, the `aws_ec2_transit_gateway` resource doesn't
fully support handling `default_route_table_assocation` or
`default_route_table_propagation`. Until that is fixed, you will need to manually
modify the TGW in the UI to set up the default route table and then set these
arguments to `true` on the Terraform resource. See:
[terraform-provider-aws issue #17398](https://github.com/hashicorp/terraform-provider-aws/issues/17398)

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's network account.
