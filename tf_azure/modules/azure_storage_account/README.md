<!-- BEGIN_TF_DOCS -->
# azure_storage

This module allows you to create a storage account with containers and private endpoints.
You can also control the storage account's firewall. In most cases, public network
access should be disabled and a private endpoint should be used.

## Private Endpoint

The VNet/subnet that the private endpoint utilizes must be in the same subscription as
the storage account. The private endpoint's DNS integration will be handled
automatically by an Azure Policy.

## Additional Info

* [Storage account overview](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
* [Introduction to Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
* [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
* [azurerm_storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
* [azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. | `string` | n/a | yes |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Whether to allow nested items within this account to opt into being public. This is<br>the same setting in the portal called "Allow blob anonymous access". | `bool` | `false` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | Container within an Azure Storage Account. | <pre>map(object({<br>    container_access_type = optional(string, "private")<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | location | `string` | `"eastus2"` | no |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the storage account | `string` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | Only one network rules block can be tied to a storage account. We currently don't have<br>support added for `virtual_network_subnet_ids` or `private_link_access`. The `default_action`<br>is automatically set to `Deny`. This action will be applied if there are no matching<br>rules. `bypass` specifies whether traffic is bypassed for Logging/Metrics/AzureServices.<br>Valid options are any combination of Logging, Metrics, AzureServices, or None. `ip_rules`<br>should be a list of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed.<br>/31 CIDRs, /32 CIDRs, and Private IP address ranges are not allowed. | <pre>object({<br>    bypass   = optional(set(string), ["AzureServices"])<br>    ip_rules = list(string)<br>  })</pre> | `null` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A collection of private endpoints to create & connect to the storage account. You<br>must create a separate private endpoint per subresource. The VNet/subnet that is<br>looked up must be in the same subscription as the storage account. | <pre>map(object({<br>    subnet = object({<br>      name                 = string<br>      resource_group_name  = string<br>      virtual_network_name = string<br>    })<br>    subresource_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow/Disallow public network access to the Storage Account | `bool` | `false` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "STORAGE")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the storage account |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Examples

```hcl
# Example 1 - Cool storage account with no containers
storage_accounts = {
  "storageprojectwisebackup" = {
    access_tier              = "Cool"
    account_kind             = "StorageV2"
    account_replication_type = "LRS"
    account_tier             = "Standard"
    location                 = "eastus2"
    resource_group_name      = "rg-infraops-prod-01"
    tags = {
      JobWbs = "897720-01102"
    }
  }
}

# Example 2 - Hot storage account with a container
storage_accounts = {
  "stparsonstfstatecomm" = {
    account_replication_type = "LRS"
    account_tier             = "Standard"
    containers = {
      tfstate = {
        container_access_type = "private"
      }
    }
    location            = "eastus2"
    resource_group_name = "rg-infraops-prod-01"
  }
}

# Example 3 - Storage account with public network access enabled from selected IP addresses
storage_accounts = {
  "storageprojectwisebackup" = {
    access_tier                   = "Cool"
    account_kind                  = "StorageV2"
    account_replication_type      = "LRS"
    account_tier                  = "Standard"
    location                      = "eastus2"
    network_rules = {
      default_action = "Allow"
      ip_rules = ["209.128.255.129"] # Sterling commercial
    }
    public_network_access_enabled = true
    resource_group_name           = "rg-infraops-prod-01"
    tags = {
      JobWbs = "897720-01102"
    }
  }
}

# Example 4 - Public network access disabled & a private endpoint for blob
storage_accounts = {
  "samikentest" = {
    account_replication_type = "LRS"
    account_tier             = "Standard"
    location = "eastus2"
    private_endpoints = {
      pep-samikentest-blob = {
        subnet = {
          name = "subnet-dmz-infraops-dev-01"
          resource_group_name = "rg-infraops-dev-01"
          virtual_network_name = "vnet-dmz-infraops-dev-eastus2"
        }
        subresource_name = "blob"
      }
    }
    resource_group_name = "rg-infraops-dev-01"
  }
}
```
<!-- END_TF_DOCS -->