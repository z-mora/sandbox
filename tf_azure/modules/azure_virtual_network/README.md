<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the virtual network | `list(string)` | `[]` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | This is the DNS local IP that will be used as the DNS IP in the virtual\_network | `list(string)` | `null` | no |
| <a name="input_gateway_subnet_address_prefix"></a> [gateway\_subnet\_address\_prefix](#input\_gateway\_subnet\_address\_prefix) | address prefix of virtual network Gateway Subnet | `list(string)` | `null` | no |
| <a name="input_is_dmz"></a> [is\_dmz](#input\_is\_dmz) | Is the VNet a DMZ. All business unit or project VNets are DMZs. If true, peer the VNet<br>to the corporate Palo Alto VNet and create a virtual hub route. If false, connect the<br>VNet to the corporate virtual WAN hub in the same region. If null, establish no<br>connectivity. | `bool` | `null` | no |
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | Is the deployment running within a Azure US Government tenant | `bool` | n/a | yes |
| <a name="input_link_dns_hub_forwarding_ruleset"></a> [link\_dns\_hub\_forwarding\_ruleset](#input\_link\_dns\_hub\_forwarding\_ruleset) | If the VNet should be linked to the DNS hub's centralized forwarding ruleset. If it's<br>linked, the DNS hub will be used for resolving DNS queries for Azure resources. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Name of the Azure region | `string` | n/a | yes |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the virtual\_network | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Collection of private subnets to create. If service endpoints aren't specified, it<br>will automatically use the list defined in locals.tf. | <pre>map(object({<br>    address_prefixes                              = list(string)<br>    delegation_actions                            = optional(list(string))<br>    delegation_name                               = optional(string)<br>    delegation_service                            = optional(string)<br>    network_security_group_id                     = string<br>    private_endpoint_network_policies_enabled     = optional(bool, false)<br>    private_link_service_network_policies_enabled = optional(bool, false)<br>    route_table_id                                = optional(string)<br>    route_table_key                               = optional(string)<br>    service_endpoints                             = optional(list(string))<br><br>  }))</pre> | `{}` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual network that was deployed |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | A map of all of the private subnets that were deployed |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_dns_resolver_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |
| [azurerm_subnet.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.private_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_hub_connection.vnet_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |
| [azurerm_virtual_hub_route_table_route.to_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_route_table_route) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.palo_alto_vnet_to_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_to_palo_alto_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_resolver_dns_forwarding_ruleset) | data source |
| [azurerm_virtual_hub.corp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub) | data source |
| [azurerm_virtual_hub_connection.to_firewall_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub_connection) | data source |
| [azurerm_virtual_network.corp_firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Examples

```hcl
# Example 1 - Corp VNet with 2 subnets, connected to virtual WAN hub, default service endpoints
virtual_networks = {
  "vnet-sandbox-test-01" = {
    cidr                   = ["10.208.68.0/22"]
    is_dmz                 = false
    location               = "eastus2"
    private_subnets = {
      "subnet-sandbox-test-01" = {
        address_prefixes       = ["10.208.68.0/25"]
        network_security_group_key = "nsg-sandbox-test-01"
      }
      "subnet-sandbox-test-02" = {
        address_prefixes       = ["10.208.68.128/25"]
        network_security_group_key = "nsg-sandbox-test-01"
      }
    }
    resource_group_name    = "rg-network-test-01"
  }
}

# Example 2 - DMZ VNet for a BU, using a user defined route table
virtual_networks = {
  "vnet-conedison-ai-dev-01" = {
    auto_create_dmz_route_table = false
    cidr                        = ["10.212.36.0/24"]
    is_dmz                      = true
    location                    = "eastus2"
    private_subnets = {
      "subnet-conedison-ai-dev-01" = {
        address_prefixes           = ["10.212.36.0/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
        route_table_key            = "rt-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-02" = {
        address_prefixes           = ["10.212.36.64/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
        route_table_key            = "rt-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-03" = {
        address_prefixes           = ["10.212.36.128/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
        route_table_key            = "rt-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-appgw-01" = {
        address_prefixes           = ["10.212.36.192/26"]
        network_security_group_key = "nsg-conedison-ai-dev-appgw-01"
        route_table_key            = "rt-conedison-ai-dev-appgw-01"
      }
    }
    resource_group_name = "rg-conedison-ai-dev-01"
  }
}

# Example 3 - DMZ VNet for a BU, using the auto generated route table
virtual_networks = {
  "vnet-conedison-ai-dev-01" = {
    cidr                   = ["10.212.36.0/24"]
    is_dmz                 = true
    location               = "eastus2"
    private_subnets = {
      "subnet-conedison-ai-dev-01" = {
        address_prefixes           = ["10.212.36.0/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-02" = {
        address_prefixes           = ["10.212.36.64/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-03" = {
        address_prefixes           = ["10.212.36.128/26"]
        network_security_group_key = "nsg-conedison-ai-dev-01"
      }
      "subnet-conedison-ai-dev-appgw-01" = {
        address_prefixes           = ["10.212.36.192/26"]
        network_security_group_key = "nsg-conedison-ai-dev-appgw-01"
      }
    }
    resource_group_name = "rg-conedison-ai-dev-01"
  }
}


# Example 4 - A DMZ VNet with some delegated subnets, using the auto generated route table
virtual_networks = {
  "vnet-itd-its-dev-01" = {
    cidr                   = ["10.212.0.0/23"]
    is_dmz                 = true
    location               = "eastus2"
    private_subnets = {
      "subnet-itd-its-dev-01" = {
        address_prefixes           = ["10.212.0.0/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-02" = {
        address_prefixes           = ["10.212.0.64/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-03" = {
        address_prefixes           = ["10.212.0.128/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-04" = {
        address_prefixes           = ["10.212.0.192/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
        delegation_name    = "Microsoft.DBforMySQL.flexibleServers"
        delegation_service = "Microsoft.DBforMySQL/flexibleServers"
        delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
      "subnet-itd-its-dev-05" = {
        address_prefixes           = ["10.212.1.0/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-06" = {
        address_prefixes           = ["10.212.1.64/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-07" = {
        address_prefixes           = ["10.212.1.128/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
      "subnet-itd-its-dev-08" = {
        address_prefixes           = ["10.212.1.192/26"]
        network_security_group_key = "nsg-itd-its-dev-01"
      }
    }
    resource_group_name = "rg-itd-its-dev-01"
  }
}
```
<!-- END_TF_DOCS -->