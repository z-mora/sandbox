<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_branch_to_branch_traffic"></a> [allow\_branch\_to\_branch\_traffic](#input\_allow\_branch\_to\_branch\_traffic) | Boolean flag to specify whether branch to branch traffic is allowed | `bool` | `true` | no |
| <a name="input_disable_vpn_encryption"></a> [disable\_vpn\_encryption](#input\_disable\_vpn\_encryption) | Boolean flag to specify whether VPN encyption is enabled or disabled | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Name of the Azure region | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID for the Azure subscription | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The virtual WAN type | `string` | `"Standard"` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | Map of objects for virtual HUBs | <pre>map(object({<br>    instance_0_custom_ip        = list(string)<br>    instance_1_custom_ip        = list(string)<br>    internet_security_enabled   = bool<br>    location                    = string<br>    remote_virtual_network_name = string<br>    routing_preference          = string<br>    scale_unit                  = number<br>    virtual_hub_address_prefix  = string<br>    vpn_gateway_name            = string<br>  }))</pre> | `{}` | no |
| <a name="input_virtual_wan_name"></a> [virtual\_wan\_name](#input\_virtual\_wan\_name) | Name of the virtual WAN | `string` | n/a | yes |
| <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites) | Map of objects for VPN connections | <pre>map(object({<br>    asn                  = number<br>    connection_link_name = string<br>    device_model         = string<br>    device_vendor        = string<br>    location             = string<br>    peering_address      = string<br>    provider_name        = string<br>    sa_data_size_kb      = number<br>    site_link_ip_address = string<br>    speed_in_mbps        = number<br>    virtual_hub_key      = string<br>    vpn_connection_name  = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_hub"></a> [virtual\_hub](#output\_virtual\_hub) | A map of all of the virtual hubs that were deployed |
| <a name="output_virtual_wan"></a> [virtual\_wan](#output\_virtual\_wan) | All of the attributes for the VWAN that was deployed |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_hub.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_virtual_hub_connection.to_palo_alto_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |
| [azurerm_virtual_wan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan) | resource |
| [azurerm_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) | resource |
| [azurerm_vpn_gateway_connection.hub_gateway_to_vpn_site](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway_connection) | resource |
| [azurerm_vpn_site.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_site) | resource |

## Examples

```hcl
# Example 1 - Commercial VWAN with multiple hubs and VPN sites
virtual_wans = {
  "wan-network-prod-01" = {
    allow_branch_to_branch_traffic = true
    disable_vpn_encryption         = false
    location                       = "eastus2"
    resource_group_name            = "rg-network-prod-01"
    type                           = "Standard"
    virtual_hubs = {
      "hub-eastus2-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.2"]
        instance_1_custom_ip        = ["169.254.22.2"]
        internet_security_enabled   = true
        location                    = "eastus2"
        remote_virtual_network_name = "vnet-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.208.0.0/23"
        vpn_gateway_name            = "vpngw-eastus2-prod-01"
      }
      "hub-uaenorth-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.18"]
        instance_1_custom_ip        = ["169.254.22.18"]
        internet_security_enabled   = true
        location                    = "uaenorth"
        remote_virtual_network_name = "vnet-uaenorth-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.232.0.0/23"
        vpn_gateway_name            = "vpngw-uaenorth-prod-01"
      }
      "hub-westus2-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.10"]
        instance_1_custom_ip        = ["169.254.22.10"]
        internet_security_enabled   = true
        location                    = "westus2"
        remote_virtual_network_name = "vnet-westus2-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.210.0.0/23"
        vpn_gateway_name            = "vpngw-westus2-prod-01"
      }
    }
    vpn_sites = {
      "vpnsite-sterling-prod-01" = {
        asn                  = 65200
        connection_link_name = "vpnlink-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "eastus2"
        peering_address      = "169.254.21.3"
        provider_name        = "megaport"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key     = "hub-eastus2-prod-01"
        vpn_connection_name  = "vpn-eastus2_sterling-prod-01"
      }
      "vpnsite-uaenorth-awsmesouth-prod-02" = {
        asn                  = 65112
        connection_link_name = "vpnlink-uaenorth-awsmesouth-prod-01"
        device_model         = "CiscoCSR"
        device_vendor        = "Cisco"
        location             = "uaenorth"
        peering_address      = "169.254.21.19"
        provider_name        = "aws"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "15.184.197.25"
        speed_in_mbps        = 1000
        virtual_hub_key     = "hub-uaenorth-prod-01"
        vpn_connection_name  = "vpn-uaenorth-awsmesouth-prod-01"
      }
      "vpnsite-westus2-sterling-prod-02" = {
        asn                  = 65200
        connection_link_name = "vpnlink-westus2-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "westus2"
        peering_address      = "169.254.21.11"
        provider_name        = "megaport"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key     = "hub-westus2-prod-01"
        vpn_connection_name  = "vpn-westus2_sterling-prod-01"
      }
    }
  }
}

# Example 2 - Gov VWAN with single hub and VPN site
virtual_wans = {
  "wan-network-prod-01" = {
    allow_branch_to_branch_traffic = true
    disable_vpn_encryption         = false
    location                       = "usgovvirginia"
    resource_group_name            = "rg-network-prod-01"
    type                           = "Standard"
    virtual_hubs = {
      "hub-usgovvirginia-prod-01" = {
        instance_0_custom_ip        = ["169.254.21.52"]
        instance_1_custom_ip        = ["169.254.22.52"]
        internet_security_enabled   = true
        location                    = "usgovvirginia"
        remote_virtual_network_name = "vnet-firewall-prod-01"
        routing_preference          = "Microsoft Network"
        scale_unit                  = 1
        virtual_hub_address_prefix  = "10.216.0.0/23"
        vpn_gateway_name            = "vpngw-usgovvirginia-prod-01"
      }
    }
    vpn_sites = {
      "vpnsite-sterling-prod-01" = {
        asn                  = 65200
        connection_link_name = "vpnlink-sterling-prod-01"
        device_model         = "CiscoASR"
        device_vendor        = "Cisco"
        location             = "usgovvirginia"
        peering_address      = "169.254.21.53"
        provider_name        = "megaport"
        resource_group_name  = "rg-network-prod-01"
        sa_data_size_kb      = 102400000
        site_link_ip_address = "209.128.255.149"
        speed_in_mbps        = 1000
        virtual_hub_key     = "hub-usgovvirginia-prod-01"
        vpn_connection_name  = "vpn-usgovvirginia_sterling-prod-01"
      }
    }
  }
}
```
<!-- END_TF_DOCS -->