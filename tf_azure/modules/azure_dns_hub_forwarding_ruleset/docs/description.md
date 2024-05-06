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
