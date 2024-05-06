<!-- BEGIN_TF_DOCS -->
# azure_route_table

This module allows you to create a route table with routes.

Route tables are automatically created by default for DMZ VNets. If you need to override
this behavior, set `auto_create_dmz_route_table` to false when defining your VNet in
tfvars. You can find the auto-generated route table definitions in the root module's
`locals.tf`. The next hop IP is "TBD" and will be looked up by a data source in this
module.

## DMZ vs Internal VNets

Business unit VNets are always considered DMZs.

Corporate VNets are typically internal. If a resource needs to be exposed to the internet
it will be a DMZ.

Internal VNets don't need a custom route table. They are integrated with the Parsons
internal network. These VNets are connected directly to the VWAN hub and inherit its
default route table (which is not the route table you see in the hub's UI). The VWAN
hub's routes are from BGP advertisements from Sterling and other Hub connections.

DMZ VNets do need a custom route table. These VNets are isolated by default. They are
peered to the Palo Alto VNet and all traffic is routed to the ILB for the firewall. If
you didn't add a custom route table, all traffic would be routed directly to the
internet, bypassing the network boundary. DMZ VNet route tables only need a single route:

| Address Prefix | Next Hop Type    | Next Hop IP Address |
|----------------|------------------|---------------------|
| 0.0.0.0/0      | VirtualAppliance | xxx.xxx.xxx.xxx     |

The next hop IP address is the IP of the ILB pointing to the Palo Altos and will differ
depending on the region.

## App Gateway Support

A separate route table should be created for App Gateway subnets (if being used), so
that the App Gateway status doesn't show as "Unknown" (See
[Backend health status: unknown](
  https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-backend-health-troubleshooting#backend-health-status-unknown
)).

The 3 required routes are below. Despite there being a default route that sends traffic
directly to the internet, the traffic will still always be routed through the Palo
Altos. The next hop IP address is the IP of the ILB pointing to the Palo Altos and will
differ depending on the region. Public access for the AGW is disabled and a private
endpoint is created. A public and DMZ load balancer would sit on either side of the
Palo Altos to route traffic to the private IP of the AGW, so traffic would always be
going to one of the two non-default routes.

| Address Prefix | Next Hop Type    | Next Hop IP Address |
|----------------|------------------|---------------------|
| 0.0.0.0/0      | Internet         | ""                  |
| 10.0.0.0/8     | VirtualAppliance | xxx.xxx.xxx.xxx     |
| 172.16.0.0/12  | VirtualAppliance | xxx.xxx.xxx.xxx     |

## Viewing Effective Routes

A lot of routes in Azure are default or inherited, and unfortunately, there isn't a
clear way to see them. The best option is to find a NIC in your subnet and view the
effective routes for it.

## Additional Info

* [Custom routes](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview#custom-routes)
* [azurerm_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/route_table)
* [What is a private endpoint?](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_bgp_route_propagation"></a> [disable\_bgp\_route\_propagation](#input\_disable\_bgp\_route\_propagation) | Do we disable BGP propagagion of learned routes into the route table? | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Name of the Azure region | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the custom route table | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Map of routes to add to the custom route table | <pre>map(object({<br>    address_prefix         = string<br>    next_hop_in_ip_address = optional(string)<br>    next_hop_type          = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the route table |

## Resources

| Name | Type |
|------|------|
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_lb.firewall_ilb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/lb) | data source |

## Examples

```hcl
# Example 1 - Route tables for DMZ VNet, including App GW RT
route_tables = {
  "rt-ad-tips-dev-01" = {
    location                      = "eastus2"
    resource_group_name           = "rg-ad-tips-dev-01"
    routes = {
      "route-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
  "rt-ad-tips-dev-appgw-01" = {
    location                      = "eastus2"
    resource_group_name           = "rg-ad-tips-dev-01"
    routes = {
      "route-10-to-ilb" = {
        address_prefix         = "10.0.0.0/8"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
      "route-172-to-ilb" = {
        address_prefix         = "172.16.0.0/12"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
      "route-default-to-internet-appgw" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = ""
        next_hop_type          = "Internet"
      }
    }
  }
}

# Example 2 - Route tables for Palo Altos
route_tables = {
  "rt-paloalto-eastus2-trust-01" = {
    location                      = "eastus2"
    resource_group_name           = "rg-network-prod-01"
    routes = {
      "route-default-to-ilb" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = "10.208.2.134"
        next_hop_type          = "VirtualAppliance"
      }
    }
  }
  "rt-paloalto-eastus2-untrust-01" = {
    disable_bgp_route_propagation = true
    location                      = "eastus2"
    resource_group_name           = "rg-network-prod-01"
    routes = {
      "route-default-to-azure-internet" = {
        address_prefix         = "0.0.0.0/0"
        next_hop_in_ip_address = ""
        next_hop_type          = "Internet"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->