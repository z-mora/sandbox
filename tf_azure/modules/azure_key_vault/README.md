<!-- BEGIN_TF_DOCS -->
# azure_key_vault

This module allows you to create a key vault with a private endpoint.

## Additional Info

* [About Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)
* [azurerm_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
* [azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
* [Integrate Key Vault with Azure Private Link](https://learn.microsoft.com/en-us/azure/key-vault/general/private-link-service)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization<br>of data actions. | `bool` | `true` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault<br>and unwrap keys. | `bool` | `null` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Specify whether Azure Resource Manager is permitted to retrieve secrets from the key<br>vault. | `bool` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of key vault to be created | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"eastus2"` | no |
| <a name="input_monitor_diagnostic_destinations"></a> [monitor\_diagnostic\_destinations](#input\_monitor\_diagnostic\_destinations) | Destinations used by azurerm\_monitor\_diagnostic\_setting to store activity logs in a<br>central location. The log analytics workspace doesn't have to be in the same region as<br>the resource. The eventhub does have to be in the same region as the resource, so they<br>are stored in a map where the key is the region. | <pre>object({<br>    eventhubs = map(object({ # key = region<br>      authorization_rule_id = string<br>      eventhub_name         = string<br>      namespace_name        = string<br>    }))<br>    log_analytics_workspace_id = string<br>    resource_group_name        = string<br>    subscription_id            = string<br>  })</pre> | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A collection of private endpoints to create & connect to the key vault.<br>`subresource_names` defaults to `['vault']`, as that is the only available<br>subresource. The VNet/subnet that is looked up must be in the same subscription as the<br>key vault. | <pre>map(object({<br>    subnet = object({<br>      name                 = string<br>      resource_group_name  = string<br>      virtual_network_name = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this Key Vault. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault?<br><br>This needs to be `true` if using the vault for disk encryption.<br><br>Once Purge Protection has been Enabled it's not possible to Disable it. Deleting the<br>Key Vault with Purge Protection Enabled will schedule the Key Vault to be deleted<br>(which will happen by Azure in the configured number of days, currently 90 days - which<br>will be configurable in Terraform in the future). | `bool` | `null` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure Resource Group Name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can<br>be between 7 and 90 days. This field can only be configured one time and cannot be<br>updated. | `number` | `90` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the key vault |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.key_vault_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Examples

```hcl
# Example 1 - Key vault with public network access enabled
key_vaults = {
  "corp-netapp-test-01-disk" = {
    enable_rbac_authorization     = true
    enabled_for_disk_encryption   = true
    location                      = "eastus2"
    public_network_access_enabled = true
    purge_protection_enabled      = true
    resource_group_name           = "rg-netapp-test-01"
    soft_delete_retention_days    = 7
  }
}

# Example 2 - Key vault with public access disabled & a private endpoint
key_vaults = {
  kv-parsons-gpt-prod-va = {
    enable_rbac_authorization   = null
    enabled_for_disk_encryption = null
    location = "usgovvirginia"
    private_endpoints = {
      pep-kv-parsons-gpt-prod-usgovvirginia = {
        subnet = {
          name                 = "subnet-dmz-corp-ai-prod-usgovvirginia-01"
          resource_group_name  = "rg-corp-ai-prod-01"
          virtual_network_name = "vnet-dmz-corp-ai-prod-usgovvirginia-01"
        }
      }
    }
    purge_protection_enabled = null
    resource_group_name = "rg-parsons-gpt-prod-usgovvirginia"
    soft_delete_retention_days = null
  }
}
```
<!-- END_TF_DOCS -->