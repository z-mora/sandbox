# aws_customer_gateway

This module will allow you to deploy a customer gateway with 1 or more site-to-site VPN
connections to connect it to a transit gateway.

At the moment, the VPN options are not built out and don't seem to be used at Parsons.
However, `vpn_connections` is already declared as a map of objects to support forward
compatibility.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's network account.
