# azure_palo_alto

This module deploys a Palo Alto VM Series virtual machine and its associated resources.
The official Palo Alto vmseries module is no longer used, as it seemed that every time
they release a new version it wanted to redeploy our infrastructure. We copied their
module's source and are using that with some modifications.

In addition to the VM, a `null_resource` is used to run an Azure CLI command to set up
licensing.

> NOTE: When defining interfaces, the management interface must be first in the list.
> The ordering of the interfaces matters, which is why a list is used instead of a map

## Additional Info

* [vmseries-modules](https://registry.terraform.io/modules/PaloAltoNetworks/vmseries-modules/azurerm/latest)
* [null-resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource.html)
* [azurerm_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine)
