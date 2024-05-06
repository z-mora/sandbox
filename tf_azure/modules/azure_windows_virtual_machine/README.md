<!-- BEGIN_TF_DOCS -->
# azure_windows_virtual_machine

This module allows you to deploy a Windows virtual machine.

* Multiple network interfaces and managed disks can be created/attached
* Disk encryption can be enabled by providing the name of a vault
* Backups can be enabled by providing a recovery vault name and a backup policy name
* The username will always be `par_admin` and the password is randomly generated (which
can be found in the outputs)
  * If you choose to join the VM to the domain, the local admin password in the outputs
  will no longer be accurate, as BeyondTrust will take over management of the account.
  It will reset the password and make it available in vault.parsons.com

## Additional Info

* [azurerm_windows_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine)
* [azurerm_virtual_machine_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) (Used for the domain join)
* [azurerm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk)
* [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)
* [azurerm_backup_protected_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup"></a> [backup](#input\_backup) | If the VM should be backed up, specify the name of a recovery services vault and the<br>ID of one of its backup policies to use. IF the VM should not be backed up, omit this<br>variable. | <pre>object({<br>    policy_id           = string<br>    recovery_vault_name = string<br>  })</pre> | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the internal OS disk in GB | `number` | `"80"` | no |
| <a name="input_domain_join"></a> [domain\_join](#input\_domain\_join) | whether to domain join the VM | `bool` | n/a | yes |
| <a name="input_domain_join_build_script"></a> [domain\_join\_build\_script](#input\_domain\_join\_build\_script) | base64 byte string of build script | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the key vault used for disk encryption | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"eastus2"` | no |
| <a name="input_managed_disks"></a> [managed\_disks](#input\_managed\_disks) | Object map of Managed Disks | <pre>map(object({<br>    create_option        = string<br>    disk_size_gb         = number<br>    lun                  = number<br>    storage_account_type = string<br>    tier                 = string<br>    zone                 = number<br>  }))</pre> | `{}` | no |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | Object map of Network Interfaces | <pre>map(object({<br>    enable_accelerated_networking = bool<br>    enable_ip_forwarding          = bool<br>    private_ip_address_allocation = string<br>    subnet_key                    = string<br>  }))</pre> | `{}` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Private Subnets | <pre>map(object({<br>    id = string<br>  }))</pre> | n/a | yes |
| <a name="input_required_tags"></a> [required\_tags](#input\_required\_tags) | Required Azure tags | <pre>object({<br>    App           = string<br>    Domain        = optional(string)<br>    EC2Scheduler  = optional(string)<br>    Environment   = string<br>    GBU           = string<br>    ITSM          = optional(string, "SERVER")<br>    JobWbs        = string<br>    Notes         = optional(string)<br>    Owner         = string<br>    SnapshotDaily = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The SKU for this Virtual Machine size | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the OS image used to create the Virtual Machines | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The type of Storage Account that should back this internal OS disk | `string` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The timezone in which this VM resides | `string` | n/a | yes |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | Virtual Machine name | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The Availability Zone which this Windows VM is located | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Windows VM |
| <a name="output_initial_admin_password"></a> [initial\_admin\_password](#output\_initial\_admin\_password) | The initial admin password for the VM for the par\_admin local user. If you join this<br>  VM to the domain, this password will no longer be valid as it will be changed and<br>  managed by BeyondTrust. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The primary private IP assigned to the Windows VM |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | A list of private IPs assigned to the Windows VM |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_disk_encryption_set.rsa_encryption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.disk_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_managed_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_role_assignment.disk_set_permissions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.domain_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_key_vault.domain_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.domain_pass](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.domain_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Examples

```hcl
# Example 1 - Two VMs off the domain
windows_virtual_machines = {
  "vaser01nacach01" = {
    disk_encryption_key_vault = "corp-netapp-test-01-disk"
    disk_size_gb              = "250"
    domain_join               = false
    key_vault_key             = "test-key-vault"
    location                  = "eastus2"
    managed_disks = {
      "vaser01nacach01-disk2" = {
        create_option        = "Empty"
        disk_size_gb         = 1024
        lun                  = 10
        storage_account_type = "Premium_LRS"
        tier                 = "P30"
        zone                 = 1
      }
    }
    network_interfaces = {
      "vaser01nacach01-nic1" = {
        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet-netapp-test-01"
      }
    }
    resource_group_name       = "rg-netapp-test-01"
    size                      = "Standard_D4s_v3"
    sku                       = "2019-datacenter-gensecond"
    storage_account_type      = "Premium_LRS"
    timezone                  = "Eastern Standard Time"
    virtual_network           = "vnet-netapp-test-01"
    zone                      = 1
  }
  "vaser01nacore01" = {
    disk_encryption_key_vault = "corp-netapp-test-01-disk"
    disk_size_gb              = "250"
    domain_join               = false
    key_vault_key             = "test-key-vault"
    location                  = "eastus2"
    managed_disks = {
      "vaser01nacore01-disk2" = {
        create_option        = "Empty"
        disk_size_gb         = 4
        lun                  = 10
        storage_account_type = "Premium_LRS"
        tier                 = "P1"
        zone                 = 1
      }
    }
    network_interfaces = {
      "vaser01nacore01-nic1" = {
        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        private_ip_address_allocation = "Dynamic"
        subnet                        = "subnet-netapp-test-01"
      }
    }
    resource_group_name       = "rg-netapp-test-01"
    size                      = "Standard_D4s_v3"
    sku                       = "2019-datacenter-gensecond"
    storage_account_type      = "Premium_LRS"
    timezone                  = "Eastern Standard Time"
    virtual_network           = "vnet-netapp-test-01"
    zone                      = 1
  }
}

# Example 2 - VM with backups configured
windows_virtual_machines = {
  "testmachine" = {
    backup                    = {
      policy_key              = "test-backup-policy"
      rsv_key                 = "recovery-services-vault-test"
    }
    disk_encryption_key_vault = "corp-cps-prod-01-disk"
    disk_size_gb              = "127"
    domain_join               = false
    key_vault_key             = "test-key-vault"
    location                  = "eastus2"
    managed_disks = {
      "testmachine-disk2" = {
        create_option        = "Empty"
        disk_size_gb         = 50
        lun                  = 10
        storage_account_type = "Premium_LRS"
        tier                 = "P10"
        zone                 = 1
      }
    }
    network_interfaces = {
      "testmachine-network-interface1" = {
        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet-cps-prod-01"
      }
      "testmachine-network-interface2" = {
        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet-cps-prod-01"
      }
    }
    resource_group_name       = "rg-cps-prod-01"
    size                      = "Standard_B2s"
    sku                       = "2019-datacenter-gensecond"
    storage_account_type      = "Premium_LRS"
    timezone                  = "Central Standard Time"
    virtual_network           = "vnet-cps-prod-01"
    zone                      = 1
  }
}
```
<!-- END_TF_DOCS -->