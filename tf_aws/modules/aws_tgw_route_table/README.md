<!-- BEGIN_TF_DOCS -->
# aws_tgw_route_table

This module will create a new transit gateway route table. The module can either be used
to create an empty, central route table for a transit gateway, or a route table for a
DMZ VPC. All BU VPCs are considered DMZs.
The variables for each type of deployment should be used exclusively from one another.

> NOTE: Internal, corporate VPCs do not need their own route table. There's a default
> route table that gets automatically associated to corporate VPCs, which allows them
> all to be part of the internal network.

## DMZ Deployment

Every BU VPC is considered a DMZ and needs its own transit gateway route table for
connectivity, which also keeps each VPC isolated. Corporate VPCs can also be DMZs. A
corporate VPC is considered a DMZ if it will have any services exposed to the internet.

Only one transit gateway route table should be created per account per region. For
example, if you have 3 DMZ VPCs in an account in us-east-1, you would create a single
transit gateway route table for that account/region and associate it to each transit
gateway VPC attachment. `tgw_vpc_attachment_ids` must contain the ID of each attachment.

By default, 2 blackhole routes will be created so that traffic destined for the DMZ
address space is dropped to ensure that the VPCs remain isolated from one another. These
routes can be overriden by setting custom CIDRs in `override_blackhole_cidrs`.

By default, routes from the transit gateway's VPN attachments also get propagated to
the route table.

## TGW Deployment

This module can be used to create an empty, central transit gateway route table by only
specifying a `name` and `transit_gateway_id`.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's network account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the transit gateway route table | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | The ID of the current organization | `string` | n/a | yes |
| <a name="input_override_blackhole_cidrs"></a> [override\_blackhole\_cidrs](#input\_override\_blackhole\_cidrs) | A set of CIDRs to create blackhole routes for. Only use if you don't want to use the<br>default CIDRs in `local.blackhole_cidrs`. Do not use with `transit_gateway_id`. | `set(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_tgw_vpc_attachment_ids"></a> [tgw\_vpc\_attachment\_ids](#input\_tgw\_vpc\_attachment\_ids) | The transit gateway VPC attachment IDs of the BU VPCs in this region that you<br>want to set up the route table for. Do not use with `transit_gateway_id`. The key<br>should be the VPC key and the value should be the VPC's transit gateway attachment ID.<br>This must be a map so the keys will be known before apply. | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | The ID of of the transit gateway that the route table is for. Should be used if you're<br>creating an empty route table in a corporate account. Do not use with<br>`tgw_vpc_attachment_ids`. The key should be the transit gateway key and the value<br>should be the transit gateway ID. There should only be one item in the map. This must<br>be a map so the keys will be known before apply. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_association_route_table"></a> [default\_association\_route\_table](#output\_default\_association\_route\_table) | If this is the default association route table for the TGW |
| <a name="output_default_propagation_route_table"></a> [default\_propagation\_route\_table](#output\_default\_propagation\_route\_table) | If this is the default propagation route table for the TGW |
| <a name="output_id"></a> [id](#output\_id) | The ID of the transit gateway route table |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route.blackhole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.vpc_to_project_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.vpc_to_central_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.vpc_to_project_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.vpn_to_project_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_attachment.first_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_attachment) | data source |
| [aws_ec2_transit_gateway_attachments.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_attachments) | data source |
| [aws_ec2_transit_gateway_vpc_attachment.looking_up_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_vpc_attachment) | data source |

## Examples

```hcl
# Example 1 - TGW RT for a BU VPC
tgw_route_tables = {
  "tgw-route-table-inf-nittec-prod-tgw-route-table" = {
    vpc_keys = ["vpc-dmz-parsons-com-nittec-prod-01"]
  }
}

# Example 2 - Empty TGW RT in a corp networking account
tgw_route_tables = {
  "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it-vpn-route-table" = {
    transit_gateway_key = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
  }
}
```
<!-- END_TF_DOCS -->