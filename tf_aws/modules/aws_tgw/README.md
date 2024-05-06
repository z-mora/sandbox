<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range<br>  is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. | `number` | `64512` | no |
| <a name="input_auto_accept_shared_attachments"></a> [auto\_accept\_shared\_attachments](#input\_auto\_accept\_shared\_attachments) | Whether resource attachment requests are automatically accepted. | `bool` | `false` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR<br>block or larger for IPv4, or a size /64 CIDR block or larger for IPv6. | `list(string)` | `null` | no |
| <a name="input_default_route_table_association"></a> [default\_route\_table\_association](#input\_default\_route\_table\_association) | If attachments are automatically associated with the default association route table. | `bool` | `false` | no |
| <a name="input_default_route_table_propagation"></a> [default\_route\_table\_propagation](#input\_default\_route\_table\_propagation) | Whether resource attachments automatically propagate routes to the default propagation route table. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the EC2 Transit Gateway | `string` | n/a | yes |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether DNS support is enabled | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the transit gateway | `string` | n/a | yes |
| <a name="input_share_to_principals"></a> [share\_to\_principals](#input\_share\_to\_principals) | A set of principals to share the transit gateway with by using the Resource Access<br>Manager service. Possible values are an AWS account ID, an AWS Organizations<br>Organization ARN, or an AWS Organizations Organization Unit ARN. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_vpn_ecmp_support"></a> [vpn\_ecmp\_support](#input\_vpn\_ecmp\_support) | Whether VPN Equal Cost Multipath Protocol support is enabled | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the transit gateway |
| <a name="output_resource_share_arn"></a> [resource\_share\_arn](#output\_resource\_share\_arn) | The ARN of the resource share |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |

## Examples

```hcl
# Example 1 - TGW shared to an org
transit_gateways = {
  "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it" = {
    amazon_side_asn                = 65028
    auto_accept_shared_attachments = true
    description                    = "tgw-1-ci-internal-us-west-2-to-us-west-2-corp-it"
    share_to_principals = [
      "arn:aws:organizations::615231544573:organization/o-x0augfafh3",
    ]
  }
}
```
<!-- END_TF_DOCS -->