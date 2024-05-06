<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerated_networking"></a> [accelerated\_networking](#input\_accelerated\_networking) | Enable Azure accelerated networking (SR-IOV) for all network interfaces except the<br>primary one (it is the PAN-OS management interface, which [does not support](<br>  https://docs.paloaltonetworks.com/pan-os/9-0/pan-os-new-features/virtualization-features/support-for-azure-accelerated-networking-sriov<br>) acceleration). | `bool` | `true` | no |
| <a name="input_app_insights_settings"></a> [app\_insights\_settings](#input\_app\_insights\_settings) | A map of the Application Insights related parameters.<br><br>If the variable is:<br>- not defined - Application Insights will not be created (default behavior)<br>- defined as empty map `{}` - Application Insights will be created based on the default parameters<br>- defined as a map - Application Insights will be created with the defined properties, for any skipped - a default value will be used.<br><br>Available properties are:<br>- `name`                      - (optional\|string) Name of the Applications Insights<br>  instance. Can be `null`, in which case a default name is auto-generated.<br>- `workspace_mode`            - (optional\|bool)   Application Insights mode. If `true`<br>  (default), the "Workspace-based" mode is used. With `false`, the mode is set to legacy "Classic".<br>- `metrics_retention_in_days` - (optional\|number) Specifies the retention period in days.<br>  Possible values are 0, 30, 60, 90, 120, 180, 270, 365, 550 or 730. Azure defaults is 90.<br>- `log_analytics_name`        - (optional\|string) The name of the Log Analytics workspace.<br>  Can be `null`, in which case a default name is auto-generated.<br>- `log_analytics_sku`         - (optional\|string) Azure Log Analytics Workspace mode SKU.<br>  The default value is set to "PerGB2018". For more information refer to [Microsoft's documentation](https://learn.microsoft.com/en-us/azure/azure-monitor//usage-estimated-costs#moving-to-the-new-pricing-model)<br><br>NOTICE. Azure support for classic Application Insights mode will end on Feb 29th 2024.<br>It's already not available in some of the new regions.<br><br>NOTICE. Since upgrade to provider 3.x when destroying infrastructure with a classic<br>Application Insights a resource is being left behind:<br>`microsoft.alertsmanagement/smartdetectoralertrules`. This resource is not present in<br>the state and it prevents resource group deletion.<br><br>A workaround is to set the following provider configuration:<pre>provider "azurerm" {<br>  features {<br>    resource_group {<br>      prevent_deletion_if_contains_resources = false<br>    }<br>  }<br>}<br><br>Example:</pre>{<br>      name                      = "AppInsights"<br>      workspace\_mode            = true<br>      metrics\_retention\_in\_days = 30<br>      log\_analytics\_name        = "LogAnalyticsName"<br>      log\_analytics\_sku         = "PerGB2018"<br>  }<pre></pre> | `map(any)` | `null` | no |
| <a name="input_avset_id"></a> [avset\_id](#input\_avset\_id) | The identifier of the Availability Set to use. When using this variable, set `avzone = null`. | `string` | `null` | no |
| <a name="input_bootstrap_options"></a> [bootstrap\_options](#input\_bootstrap\_options) | Bootstrap options to pass to VM-Series instance.<br><br>Proper syntax is a string of semicolon separated properties.<br>Example:<br>  bootstrap\_options = "type=dhcp-client;panorama-server=1.2.3.4"<br><br>A list of available properties: storage-account, access-key, file-share,<br>share-directory, type, ip-address, default-gateway, netmask, ipv6-address,<br>ipv6-default-gateway, hostname, panorama-server, panorama-server-2, tplname, dgname,<br>dns-primary, dns-secondary, vm-auth-key, op-command-modes, op-cmd-dpdk-pkt-io,<br>plugin-op-commands, dhcp-send-hostname, dhcp-send-client-id, dhcp-accept-server-hostname,<br>dhcp-accept-server-domain, auth-key, vm-series-auto-registration-pin-value,<br>vm-series-auto-registration-pin-id.<br><br>For more details on bootstrapping see documentation:<br>https://docs.paloaltonetworks.com/vm-series/10-2/vm-series-deployment/bootstrap-the-vm-series-firewall/create-the-init-cfgtxt-file/init-cfgtxt-file-components | `string` | `""` | no |
| <a name="input_diagnostics_storage_uri"></a> [diagnostics\_storage\_uri](#input\_diagnostics\_storage\_uri) | The storage account's blob endpoint to hold diagnostic files. | `string` | `null` | no |
| <a name="input_enable_zones"></a> [enable\_zones](#input\_enable\_zones) | If false, the input `avzone` is ignored and also all created Public IP addresses default<br>to not to use Availability Zones (the `No-Zone` setting). It is intended for the regions<br>that do not yet support Availability Zones. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | See the [provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#identity_ids). | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | See the [provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#identity_type). | `string` | `"SystemAssigned"` | no |
| <a name="input_img_offer"></a> [img\_offer](#input\_img\_offer) | The Azure Offer identifier corresponding to a published image. For `img_version` 9.1.1 or above, use "vmseries-flex"; for 9.1.0 or below use "vmseries1". | `string` | `"vmseries-flex"` | no |
| <a name="input_img_publisher"></a> [img\_publisher](#input\_img\_publisher) | The Azure Publisher identifier for the image which will be deployed | `string` | `"paloaltonetworks"` | no |
| <a name="input_img_sku"></a> [img\_sku](#input\_img\_sku) | VM-series SKU - list available with `az vm image list -o table --all --publisher paloaltonetworks` | `string` | `"byol"` | no |
| <a name="input_img_version"></a> [img\_version](#input\_img\_version) | The VM-series PAN-OS version. You can list what's available for a default `img_offer`<br>with  the command:<br>`az vm image list -o table --publisher paloaltonetworks --offer vmseries-flex --all` | `string` | `"10.1.0"` | no |
| <a name="input_interfaces"></a> [interfaces](#input\_interfaces) | An ordered list of the network interfaces.<br><br>NOTE: The ORDER in which you specify the interfaces DOES MATTER.<br>Interfaces will be attached to VM in the order you define here, therefore:<br>* The first should be the management interface, which does not participate in data filtering<br>* The remaining ones are the dataplane interfaces<br><br>Options for an interface object:<br>- `create_public_ip`     - (optional\|bool) If true, create a public IP for the interface.<br>  Default is false<br>- `enable_ip_forwarding` - (optional\|bool) If true, the network interface will not<br>  discard packets sent to an IP address other than the one assigned. If false, the network interface only accepts traffic destined to its IP address<br>- `name`                 - (required\|string) Interface name<br>- `private_ip_address`   - (optional\|string) Static private IP to asssign to the interface.<br>  If null, dynamic one is allocated<br>- `subnet_name`          - (required\|string) Name of an existing subnet to create<br>  interface in. It must reside in the resource group<br>- `vnet_name`            - (required\|string) Name of an existing VNet that the subnet is in | <pre>list(object({<br>    create_public_ip     = optional(bool, false)<br>    enable_ip_forwarding = optional(bool, true)<br>    name                 = string<br>    private_ip_address   = optional(string)<br>    subnet_name          = string<br>    vnet_name            = string<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region where to deploy VM-Series and dependencies. | `string` | n/a | yes |
| <a name="input_managed_disk_type"></a> [managed\_disk\_type](#input\_managed\_disk\_type) | The type of OS Managed Disk to create for the virtual machine. Possible values are<br>`Standard_LRS`, `StandardSSD_LRS` or `Premium_LRS`. The `Premium_LRS` works only for<br>selected `vm_size` values, details in Azure docs. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_name"></a> [name](#input\_name) | VM-Series instance name. | `string` | n/a | yes |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | Optional name of the OS disk to create for the virtual machine. If empty, the name is auto-generated. | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Initial administrative password to use for VM-Series. If not defined the `ssh_key`<br>variable must be specified. Mind the [Azure-imposed restrictions](<br>  https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-password-requirements-when-creating-a-vm<br>). | `string` | `null` | no |
| <a name="input_public_ip_zones"></a> [public\_ip\_zones](#input\_public\_ip\_zones) | A collection containing the availability zone to allocate the Public IP in. Changing<br>this forces a new resource to be created. Availability Zones are only supported with a<br>Standard SKU and in select regions at this time. Standard SKU Public IP Addresses that<br>do not specify a zone are not zone-redundant by default. | `list(number)` | `null` | no |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App         = string<br>    Environment = string<br>    GBU         = string<br>    ITSM        = optional(string, "NETWORK")<br>    JobWbs      = string<br>    Notes       = optional(string)<br>    Owner       = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the existing resource group where to place the resources created. | `string` | n/a | yes |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | A list of initial administrative SSH public keys that allow key-pair authentication.<br><br>This is a list of strings, so each item should be the actual public key value. If you<br>would like to load them from files instead, following method is available:<pre>[<br>  file("/path/to/public/keys/key_1.pub"),<br>  file("/path/to/public/keys/key_2.pub")<br>]</pre>If the `password` variable is also set, VM-Series will accept both authentication methods. | `list(string)` | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The ID for the Azure subscription where the VMs will be deployed | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The initial administrator username to use for VM-Series. Mind the<br>[Azure-imposed restrictions](<br>  https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm<br>) | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The Azure VM size (type) to be created. Consult the "VM-Series Deployment Guide", as<br>only a few selected sizes are supported | `string` | `"Standard_D3_v2"` | no |
| <a name="input_vm_zone"></a> [vm\_zone](#input\_vm\_zone) | A single availability zone which the virtual machine should be allocated in. Changing<br>this forces a new resource to be created. Ignored if `enable_zones` is false.<br>Conflicts with `avset_id`, in which case use `avzone = null`." | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual machine |
| <a name="output_interface_ips"></a> [interface\_ips](#output\_interface\_ips) | Map of interfaces and their IPs |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [null_resource.palo_alto_agreement](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Examples

```hcl
# Example 1 - Two Palo Alto VMs in westus2
palo_altos = {
  "waser01pafw01" = {
    avzone                            = "1"
    img_version                       = "10.1.8"
    interfaces = [
      {
        name = "interface-palo_management-prod-1"
        subnet_name = "subnet-westus2-palo_management-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
      {
        create_public_ip = true
        name = "interface-palo_untrust-prod-1"
        subnet_name = "subnet-westus2-palo_untrust-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
      {
        name = "interface-palo_trust-prod-1"
        subnet_name = "subnet-westus2-palo_trust-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
    ]
    location                          = "westus2"
    password                          = ""
    resource_group_name               = "rg-network-prod-01"
    username                          = "panadmin"
    vm_size                           = "Standard_DS3_v2"
  }
  "waser01pafw02" = {
    avzone                            = "2"
    img_version                       = "10.1.8"
    interfaces = [
      {
        name = "interface-palo_management-prod-2"
        subnet_name = "subnet-westus2-palo_management-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
      {
        create_public_ip = true
        name = "interface-palo_untrust-prod-2"
        subnet_name = "subnet-westus2-palo_untrust-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
       {
        name = "interface-palo_trust-prod-2"
        subnet_name = "subnet-westus2-palo_trust-prod-01"
        vnet_name = "vnet-westus2-firewall-prod-01"
      },
    ]
    location                          = "westus2"
    password                          = ""
    resource_group_name               = "rg-network-prod-01"
    username                          = "panadmin"
    vm_size                           = "Standard_DS3_v2"
  }
}
```
<!-- END_TF_DOCS -->