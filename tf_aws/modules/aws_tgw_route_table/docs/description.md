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
