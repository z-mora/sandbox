# azure_virtual_network

This module allows you to deploy a virtual network (VNet) with subnets. Some Azure PaaS
services require delegated subnets. Make sure you look up the networking requirements
for each service you plan to use.

## Connectivity

This module automatically handles connecting the VNet to the network based on the
variable `is_dmz`. The corporate resources that the VNet is connected to are in the
network subscription and are automatically looked up using data sources. It's assumed
that they're in a resource group called `rg-network-prod-01`. For more info on the setup
differences between a DMZ VNet and an internal VNet, see the documentation for the
module `azure_tgw_route_table`.

* true
  * All business unit VNets are considered DMZs. This will peer a VNet to the region's
  Palo Alto VNet
  * DNS servers are set to use Azure Provided DNS
for BU VNets
* false
  * This will connect a VNet to the region's virtual WAN hub, which should only be used
  for non-DMZ corporate VNets
  * DNS servers are set based on whether the environment is Commercial or Gov
    * GOV - 10.33.254.16/10.33.254.76
    * COMM - 10.0.4.16/10.0.4.18
* null
  * This should only be used for some exceptions, such as a Palo Alto VNet which doesn't
  fall under one of the two options above.

## Route Tables

By default, route tables will be automatically configured for DMZ VNets to ensure that
traffic is routed through the ILB for the Palo Alto firewall. If you need to override
this behavior, set `auto_create_dmz_route_table` to false when defining your VNet in
tfvars. For more info on route tables see the documentation for the module
`azure_tgw_route_table`.

## Service Endpoints

Subnets default to having the following service endpoints associated. Service endpoints
provide secure and direct connectivity to Azure services over an optimized route over
the Azure backbone network. These are free to add and are commonly used services at
Parsons. If you need custom behavior you can use the `service_endpoints` attribute on
each subnet you define.

* Microsoft.AzureActiveDirectory
* Microsoft.CognitiveServices
* Microsoft.ContainerRegistry
* Microsoft.EventHub
* Microsoft.KeyVault
* Microsoft.ServiceBus
* Microsoft.Sql
* Microsoft.Storage
* Microsoft.Web

## Provider Requirements

This module requires two providers:

1) A default provider which is configured for the subscription where the virtual
network will be created
2) A non-default provider with the alias `azurerm.corp_network` which is configured
for the production network subscription in the current tenant. This is used to connect
the new VNet to the virtual WAN hub or peer the new VNet to the Palo Alto VNet.

## Additional Info

* [What is Azure Virtual Network?](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
* [What is subnet delegation](https://learn.microsoft.com/en-us/azure/virtual-network/subnet-delegation-overview)
* [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network.html)
* [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
* [Virtual Network service endpoints](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview)
