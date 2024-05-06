<!-- BEGIN_TF_DOCS -->
# azure_dns_hub_forwarding_ruleset

This module will deploy a centralized DNS forwarding ruleset in the DNS hub. It will
create a rule for each private link hostname to direct queries to the inbound endpoint
of the private resolver. Every DMZ VNet should be linked to the forwarding ruleset in the
same region so it can resolve private link records.

## Custom Rules

Custom rules should be used if you need to force DNS to resolve a resource's public
endpoint. This would be required if an entity outside of Parsons is sharing a resource
via its public endpoint, but they also have a private endpoint configured. If a custom
rule doesn't get created, the lookup will fail because the private DNS resolver will
attempt to find the private link record in the private DNS zone for that service, which
won't exist since the resource isn't managed by Parsons.

## Provider Requirements

This module requires a single, default provider for the current subscription (which
should be the DNS hub).

## Additional Info

* [Azure DNS Private Resolver endpoints and rulesets](https://learn.microsoft.com/en-us/azure/dns/private-resolver-endpoints-rulesets)
* [azurerm_private_dns_resolver_dns_forwarding_ruleset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset)
* [azurerm_private_dns_resolver_forwarding_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule)
* [azurerm_private_dns_resolver_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | A collection of custom rules to be created in the forwarding ruleset. The key is the<br>domain name (without a period at the end). Each target DNS server should be in the<br>format "IP:port". This should only be used if you need to force resolution of a<br>resource's public endpoint. | <pre>map(object({<br>    enabled            = optional(bool, true)<br>    target_dns_servers = set(string)<br>  }))</pre> | `{}` | no |
| <a name="input_inbound_endpoint_ip"></a> [inbound\_endpoint\_ip](#input\_inbound\_endpoint\_ip) | The private IP of the DNS private resolver's inbound endpoint that DNS queries will be<br>routed to. This will be the target DNS server for each of the rules. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The region where the forwarding ruleset will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the forwarding ruleset | `string` | n/a | yes |
| <a name="input_outbound_endpoint_id"></a> [outbound\_endpoint\_id](#input\_outbound\_endpoint\_id) | The ID of the DNS private resolver's outbound endpoint | `string` | n/a | yes |
| <a name="input_private_link_zone_names"></a> [private\_link\_zone\_names](#input\_private\_link\_zone\_names) | The list of private link zone names that exist in the DNS hub. Each zone will have a<br>rule created in the ruleset. | `set(string)` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group where the forwarding ruleset will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the forwarding ruleset |
| <a name="output_location"></a> [location](#output\_location) | The region of the forwarding ruleset |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_forwarding_rule.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |
| [azurerm_private_dns_resolver_forwarding_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |

## Examples

```hcl
# Example 1 - Basic DNS hub forwarding ruleset
dns_hub_forwarding_rulesets = {
  dnsfrs-prod-eastus2-01 = {
    location             = "eastus2"
    private_resolver_key = "dnspr-prod-eastus2-01"
    resource_group_name  = "rg-dns-prod-01"
  }
}

# Example 2 - DNS hub forwarding ruleset with a custom rule, which forces resolution of
# the public IP for the resource by using the Parsons DNS cache servers
dns_hub_forwarding_rulesets = {
  dnsfrs-hub-prod-eastus2-01 = {
    custom_rules = {
      "miketestpublicsa.blob.core.windows.net" = {
        target_dns_servers = ["10.41.129.140:53", "10.41.131.230:53"]
      }
    }
    location             = "eastus2"
    private_resolver_key = "dnspr-prod-eastus2-01"
    resource_group_name  = "rg-dns-prod-01"
  }
}
```
<!-- END_TF_DOCS -->