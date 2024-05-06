<!-- BEGIN_TF_DOCS -->
# aws_customer_gateway

This module will allow you to deploy a customer gateway with 1 or more site-to-site VPN
connections to connect it to a transit gateway.

At the moment, the VPN options are not built out and don't seem to be used at Parsons.
However, `vpn_connections` is already declared as a map of objects to support forward
compatibility.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's network account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_asn"></a> [bgp\_asn](#input\_bgp\_asn) | The gateway's BGP ASN | `number` | n/a | yes |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | The IPv4 address for the customer gateway device's outside interface | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name for the customer gateway device | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_vpn_connections"></a> [vpn\_connections](#input\_vpn\_connections) | value | <pre>map(object({<br>    transit_gateway_id = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the customer gateway |
| <a name="output_vpn_ids"></a> [vpn\_ids](#output\_vpn\_ids) | Map of site-to-site VPN connection keys and IDs |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpn_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |

## Examples

```hcl
# Example 1 - 2 customer gateways, both with a S2S VPN connecting to the same TGW
customer_gateways = {
  "CGW-35.166.183.205" = {
    bgp_asn = 65026
    ip_address = "35.166.183.205"
    vpn_connections = {
      "VPN-to-CGW-35.166.183.205" = {
        transit_gateway_key = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
      }
    }
  }
  "CGW-44.236.58.115" = {
    bgp_asn = 65026
    ip_address = "44.236.58.115"
    vpn_connections = {
      "VPN-to-CGW-44.236.58.115" = {
        transit_gateway_key = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->