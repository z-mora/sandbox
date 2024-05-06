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
