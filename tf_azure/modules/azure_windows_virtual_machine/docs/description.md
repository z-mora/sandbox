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
