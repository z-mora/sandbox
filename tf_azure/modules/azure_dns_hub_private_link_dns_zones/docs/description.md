# azure_dns_hub_private_link_dns_zones

This module will deploy private DNS zones for most of Azure's private link services
listed in the Microsoft documentation below. It also allows you to link virtual networks
to each zone.

Private DNS zones are global resources.

For zones names that specify a region, the following Parsons-supported regions are used:

* EastUS2
* WestUS2
* USGovVirginia

> Note: We've removed some of the private DNS zones after DNS resolution issues were
> reported when their corresponding conditional forwarder was added to AD DNS. See
> locals.tf for more info on these.

## Provider Requirements

This module requires a single, default provider for the subscription where the zones
should be created.

## Additional Info

* [Confluence - Azure DNS](https://confluence.parsons.com/display/IT/Azure+DNS)
* [Azure Private Endpoint DNS configuration](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns)
* [What is a virtual network link?](https://learn.microsoft.com/en-us/azure/dns/private-dns-virtual-network-links)
* [azurerm_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)
* [azurerm_private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)
