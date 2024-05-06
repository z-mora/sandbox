# azure_network_security_group

This module creates a network security group with inbound/outbound rules. It also
enables flowlogs for the NSG and sends them to a storage account in the logging
subscription. The NSG rules are created as a separate resource as opposed to inline.
When we hand the subscription over to users they may make adjustments to the NSG rules,
which will show up as inline rules. This is why we ignore changes to the `security_rule`
attribute on the NSG to avoid drift.

## Additional Info

* [Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
* [Flow logging for network security groups](https://learn.microsoft.com/en-us/azure/network-watcher/network-watcher-nsg-flow-logging-overview)
* [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group.html)
* [azurerm_network_security_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule)
* [azurerm_network_watcher_flow_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log)
