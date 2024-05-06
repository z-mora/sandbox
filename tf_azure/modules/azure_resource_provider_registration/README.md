<!-- BEGIN_TF_DOCS -->
# azure_resource_provider_registration

This module automatically registers the resource providers that are needed in the
subscription. It does not wait for their status to change to `Registered`.

By default, the azurerm provider will automatically register all supported resource
providers in the subscription (which is against Microsoft's guidance). It also waits for
them all to have the state `Registered` (also against Microsoft's guidance), which has been
problematic due to some resource providers getting stuck in the `Registering` state (sometimes for 12+ hours). From
[Microsoft's documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types):

> Register a resource provider only when you're ready to use it. This registration step
> helps maintain least privileges within your subscription. A malicious user can't use
> unregistered resource providers.

and:

> Your application code shouldn't block the creation of resources for a resource
> provider that is in the registering state. When you register the resource provider, the
> operation is done individually for each supported region. To create resources in a
> region, the registration only needs to be completed in that region. By not blocking a
> resource provider in the registering state, your application can continue much sooner
> than waiting for all regions to complete.

There is a resource called
[azurerm_resource_provider_registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration),
but this will also wait for the registration to be in the `Registered` state.

Due to these issues, this module uses a `null_resource` with a `local-exec` provisioner
to call the Azure CLI to register the provider, which does not wait for the status to
change.

It's worth noting that these changes won't have a huge impact on security, because if we
hand a subscription over to a project team and they use Terraform for their deployments,
their default behavior will still be to register all resource providers in the
subscription.

## Additional Info

* [local-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)
* [azurerm_resource_provider_registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration)
* [Azure resource providers and types](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types)
* [Resource providers for Azure services](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers)
* [azurerm/skip_provider_registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#skip_provider_registration)
* [azure-cli/az-provider-register](https://learn.microsoft.com/en-us/cli/azure/provider?view=azure-cli-latest#az-provider-register)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of resource provider to register | `string` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | The current OS, determined by Terragrunt. Some of the returned values can be:<br>darwin, freebsd, linux, windows<br>See: https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_platform | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID for the Azure subscription to register resource providers in | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [null_resource.provider_registration](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Examples

```hcl
# N/A
```
<!-- END_TF_DOCS -->