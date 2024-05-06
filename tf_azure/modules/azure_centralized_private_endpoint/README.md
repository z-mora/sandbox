<!-- BEGIN_TF_DOCS -->
# azure_centralized_private_endpoint

This module allows you to create a private endpoint for a resource, but in the corporate
network subscription in a VNet referred to as the "private endpoint hub". This should
only be used if the following is true:

* The resource that needs the private endpoint is in a subscription that doesn't have a
virtual network
* It's a corporate resource
* The resource should be on the internal Parsons network

This allows us to deploy private endpoints without deploying extra virtual networks that
wouldn't be needed otherwise.

> Note: The private endpoint should be created in the same region as the resource it's
> for to avoid extra charges for data transfer between regions

## Sub-resources

Since this can be used for any resource that supports private endpoints, it's important
to review what's supported for the service you'll be deploying this for. Each service
has its own sub-resources and some services require a separate private endpoint per
sub-resource.

For example, for storage accounts, [the documentation](
  https://learn.microsoft.com/en-us/azure/storage/common/storage-private-endpoints#creating-a-private-endpoint
) states that a separate private endpoint is required for each sub-resource.

## Additional Info

* [azurerm_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
* [Private-link resource](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location of the resource | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the private endpoint | `string` | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "STORAGE")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | The ID of the resource that the private endpoint should be connected to | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | A list of subresource names which the private endpoint is able to connect to.<br>`subresource_names` corresponds to group\_id. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the private endpoint |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_subnet.private_endpoint_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Examples

```hcl
# Example 1 - Creating a private endpoint using the storage account ID output from another
# deployment
# In this example the parent folder will deploy a storage account with the key
# "stparsonstfstatecomm"

# terragrunt.hcl:
include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependency "storage" {
  config_path = "../"
}

inputs = {
  centralized_private_endpoints = {
    "pep-stparsonstfstatecomm" = {
      location = "eastus2"
      resource_id = dependency.storage.outputs.storage_accounts["stparsonstfstatecomm"].id
      subresource_names = ["blob"]
    }
  }
}
```
<!-- END_TF_DOCS -->