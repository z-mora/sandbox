# azure_virtual_wan

This module allows you to deploy a Virtual WAN with virtual hubs, VPN sites, and VPN
gateways. This is used to establish connectivity between corporate VNets and other
datacenters.

Corporate VNets get connected directly to a VWAN hub. Static routes for
project VNets get added to the "Default" route table for the hub in its region.

## Additional Info

* [What is Azure Virtual WAN?](https://learn.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about)
* [azurerm_virtual_wan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan)
* [azurerm_virtual_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub)
* [azurerm_vpn_site](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_site)
* [azurerm_vpn_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway)
