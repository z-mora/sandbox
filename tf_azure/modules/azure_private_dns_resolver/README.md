<!-- BEGIN_TF_DOCS -->
# azure_private_dns_resolver

This module allows you to create a private dns resolver.

## Additional Info

* [What is Azure DNS Private Resolver](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)
* [azurerm_private_dns_resolver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_inbound_subnet_id"></a> [inbound\_subnet\_id](#input\_inbound\_subnet\_id) | The ID of the subnet to associate to the inbound resolver | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the private DNS resolver will be deployed | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the private DNS resolver to create | `string` | n/a | yes |
| <a name="input_outbound_subnet_id"></a> [outbound\_subnet\_id](#input\_outbound\_subnet\_id) | The ID of the subnet to associate to the outbound resolver | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group where the private dns resolver will be deployed. | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the Virtual Network that is linked to the Private DNS Resolver. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the private DNS resolver that was deployed. |
| <a name="output_inbound_endpoint_ip"></a> [inbound\_endpoint\_ip](#output\_inbound\_endpoint\_ip) | The private IP of the inbound endpoint |
| <a name="output_location"></a> [location](#output\_location) | The region of the private DNS resolver |
| <a name="output_outbound_endpoint_id"></a> [outbound\_endpoint\_id](#output\_outbound\_endpoint\_id) | The ID of the outbound endpoint |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |

## Examples

```hcl
# Example 1
private_dns_resolvers = {
  "resolver-dns-prod-eastus2-01" = {
    inbound_subnet_key          = "subnet-dns-prod-eastus2-01"
    location                    = "eastus2"
    outbound_subnet_key         = "subnet-dns-prod-eastus2-02"
    resource_group_name         = "rg-dns-prod-01"
    vnet_key                    = "vnet-dns-prod-eastus2-01"
  }
}

# Example 2
private_dns_resolvers = {
  "resolver-dns-prod-eastus2-01" = {
    inbound_subnet_key          = "subnet-dns-prod-eastus2-01"
    location                    = "eastus2"
    outbound_subnet_key         = "subnet-dns-prod-eastus2-02"
    resource_group_name         = "rg-dns-prod-01"
    vnet_key                    = "vnet-dns-prod-eastus2-01"
  }
  "resolver-dns-prod-westus-01" = {
    inbound_subnet_key          = "subnet-dns-prod-westus-01"
    location                    = "westus"
    outbound_subnet_key         = "subnet-dns-prod-westus-02"
    resource_group_name         = "rg-dns-prod-01"
    vnet_key                    = "vnet-dns-prod-westus-01"
  }
}
```
<!-- END_TF_DOCS -->