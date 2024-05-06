# azure_dns_hub_custom_forwarding_ruleset

This module will deploy a DNS forwarding ruleset with rules and allow you to link the
ruleset to one or more virtual networks.

This module is designed to be used when deploying a spoke/DMZ/BU VNet. The ruleset will
get created in the DNS hub subscription and will get linked to the spoke VNet(s). This
module should only be needed in unique situations where a project/business unit has its
own internal DNS server and resolution for their custom internal domain is required.

The DNS private resolver will need network connectivity to the target DNS server(s)
specified in the rules.

> Note: this module hasn't been tested thorougly yet since the use case is so uncommon

## Provider Requirements

This module requires a single, default provider for the DNS hub subscription.

## Additional Info

* [Azure DNS Private Resolver endpoints and rulesets](https://learn.microsoft.com/en-us/azure/dns/private-resolver-endpoints-rulesets)
* [azurerm_private_dns_resolver_dns_forwarding_ruleset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset)
* [azurerm_private_dns_resolver_forwarding_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule)
* [azurerm_private_dns_resolver_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link)
