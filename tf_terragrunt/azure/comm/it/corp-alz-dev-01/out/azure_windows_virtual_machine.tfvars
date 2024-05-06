windows_virtual_machines = {
  "testvm01" = {
    disk_encryption_key_vault = "corp-alz-dev-01-disk"
    disk_size_gb              = "250"
    domain_join               = false
    key_vault_key             = "corp-alz-dev-01-disk"
    location                  = "eastus2"
    managed_disks = {
      "testvm01-disk2" = {
        create_option        = "Empty"
        disk_size_gb         = 4
        lun                  = 10
        storage_account_type = "Premium_LRS"
        tier                 = "P1"
        zone                 = 1
      }
    }
    network_interfaces = {
      "testvm01-nic1" = {
        enable_accelerated_networking = false
        enable_ip_forwarding          = false
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet-alz-dev-01"
      }
    }
    resource_group_name  = "rg-alz-dev-01"
    size                 = "Standard_D4s_v3"
    sku                  = "2019-datacenter-gensecond"
    storage_account_type = "Premium_LRS"
    timezone             = "Eastern Standard Time"
    virtual_network      = "vnet-alz-dev-01"
    zone                 = 1
  }
  # "testcach01" = {
  #   disk_encryption_key_vault = "corp-netapp-test-01-disk"
  #   disk_size_gb              = "250"
  #   domain_join               = false
  #   location                  = "eastus2"
  #   managed_disks = {
  #     "testcach01-disk2" = {
  #       create_option        = "Empty"
  #       disk_size_gb         = 1024
  #       lun                  = 10
  #       storage_account_type = "Premium_LRS"
  #       tier                 = "P30"
  #       zone                 = 1
  #     }
  #   }
  #   network_interfaces = {
  #     "testcach01-nic1" = {
  #       enable_accelerated_networking = false
  #       enable_ip_forwarding          = false
  #       private_ip_address_allocation = "Dynamic"
  #       subnet                        = "subnet-netapp-test-01"
  #     }
  #   }
  #   resource_group_name  = "rg-netapp-test-01"
  #   size                 = "Standard_D4s_v3"
  #   sku                  = "2019-datacenter-gensecond"
  #   storage_account_type = "Premium_LRS"
  #   timezone             = "Eastern Standard Time"
  #   virtual_network      = "vnet-netapp-test-01"
  #   zone                 = 1
  # }
}
