<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_gov"></a> [is\_gov](#input\_is\_gov) | Is the deployment running within a Azure US Government tenant | `bool` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to use for the Private DNS Zone | `string` | n/a | yes |
| <a name="input_vnet_ids"></a> [vnet\_ids](#input\_vnet\_ids) | A map of VNets to link to each private DNS zone. The key is the key of the VNET and<br>the value is the ID. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_names"></a> [zone\_names](#output\_zone\_names) | A list of all private DNS zone names that will created |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Examples

```hcl
# Example 1
dns_hub_private_link_dns_zones = {
  resource_group_name = "rg-dns-prod-01"
  vnet_keys = [
    "vnet-int-dns-prod-eastus2-01",
    "vnet-int-dns-prod-westus2-01",
    ]
}
```
<!-- END_TF_DOCS -->