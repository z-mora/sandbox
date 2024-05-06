<!-- BEGIN_TF_DOCS -->
# azure_load_balancer

This module allows you to deploy an Azure load balancer and its associated resources.

## Additional Info

* [What is Azure Load Balancer?](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview)
* [azurerm_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_pool_addresses"></a> [backend\_pool\_addresses](#input\_backend\_pool\_addresses) | Map of objects for load balancer backend pool addresses | <pre>map(object({<br>    backend_ip_address        = string<br>    backend_pool_address_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_backend_pool_name"></a> [backend\_pool\_name](#input\_backend\_pool\_name) | Name of the load balancer backend pool | `string` | n/a | yes |
| <a name="input_frontend_name"></a> [frontend\_name](#input\_frontend\_name) | Name of the frontend ip configuration | `string` | n/a | yes |
| <a name="input_frontend_subnet"></a> [frontend\_subnet](#input\_frontend\_subnet) | Name of the frontend ip configuration subnet | `string` | n/a | yes |
| <a name="input_internal_or_external"></a> [internal\_or\_external](#input\_internal\_or\_external) | Is this an internal or external load balancer? | `string` | `"internal"` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_load_balancer_rules"></a> [load\_balancer\_rules](#input\_load\_balancer\_rules) | Map of objects for load balancer rules | <pre>map(object({<br>    backend_port          = number<br>    disable_outbound_snat = bool<br>    enable_floating_ip    = bool<br>    enable_tcp_reset      = bool<br>    frontend_port         = number<br>    idle_timeout          = number<br>    load_distribution     = string<br>    probe_interval        = number<br>    probe_name            = string<br>    probe_number          = number<br>    probe_port            = number<br>    probe_protocol        = string<br>    probe_request_path    = string<br>    protocol              = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Name of the Azure region | `string` | n/a | yes |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | Name of the public ip for the frontend ip configuration. Only valid for external load balancers. | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Type of load balancer | `string` | `"Standard"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID for the Azure subscription | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of the virtual network associated with the backend pool address | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | A list of Availability Zones which the Load Balancer's IP Addresses should be created in. | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attributes"></a> [attributes](#output\_attributes) | All of the attributes for the load balancer that was deployed |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.load_balancers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.load_balancer_backend_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool_address.load_balancer_backend_pool_address](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_probe.load_balancer_probes](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.load_balancer_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.load_balancer_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Examples

```hcl
# Example 1 - LB for a Palo Alto
load_balancers = {
  "lb-paloalto-eastus2-ilb-01" = {
    backend_pool_addresses = {
      "lb-paloalto-eastus2-ilb-backend-pool-01" = {
        backend_ip_address        = "10.208.2.132"
        backend_pool_address_name = "lb-paloalto-eastus2-ilb-backend-pool-01"
      }
      "lb-paloalto-eastus2-ilb-backend-pool-02" = {
        backend_ip_address        = "10.208.2.133"
        backend_pool_address_name = "lb-paloalto-eastus2-ilb-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-paloalto-eastus2-ilb-backend-pool-01"
    frontend_name        = "lb-paloalto-eastus2-ilb-frontend-01"
    frontend_subnet      = "subnet-palo_trust-prod-01"
    internal_or_external = "internal"
    load_balancer_rules = {
      "lb-paloalto-eastus2-ilb-rule-01" = {
        backend_port          = 0
        disable_outbound_snat = true
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 0
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-paloalto-eastus2-ilb-probe-01"
        probe_number          = 2
        probe_port            = 443
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "All"
      }
    }
    location             = "eastus2"
    public_ip_name       = ""
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
}

# Example 2 - External LB for an application
load_balancers = {
  "lb-ci-ad-tips-dev-arcgis-ext-01" = {
    backend_pool_addresses = {
      "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01" = {
        backend_ip_address        = "10.208.2.4"
        backend_pool_address_name = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01"
      }
      "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-02" = {
        backend_ip_address        = "10.208.2.5"
        backend_pool_address_name = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01"
    frontend_name        = "lb-ci-ad-tips-dev-arcgis-ext-frontend-01"
    frontend_subnet      = "subnet-palo_untrust-prod-01"
    internal_or_external = "external"
    load_balancer_rules = {
      "lb-ci-ad-tips-dev-arcgis-ext-rule-01" = {
        backend_port          = 20020
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-ad-tips-dev-arcgis-ext-probe-01"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
    }
    location             = "eastus2"
    public_ip_name       = "pip-ci-ad-tips-dev-arcgis-ext-01"
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
}
```
<!-- END_TF_DOCS -->