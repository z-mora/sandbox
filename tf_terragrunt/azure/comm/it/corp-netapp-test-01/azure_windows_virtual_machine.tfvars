windows_virtual_machines = {
  "vaser01nacach01" = {
    disk_size_gb  = "250"
    domain_join   = false
    key_vault_key = "corp-netapp-test-01-disk"
    location      = "eastus2"
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
    resource_group_name  = "rg-netapp-test-01"
    size                 = "Standard_D4s_v3"
    sku                  = "2019-datacenter-gensecond"
    storage_account_type = "Premium_LRS"
    tags                 = { Domain = "parsons.com" }
    timezone             = "Eastern Standard Time"
    virtual_network      = "vnet-netapp-test-01"
    zone                 = 1
  }
  "vaser01nacore01" = {
    disk_size_gb  = "250"
    domain_join   = false
    key_vault_key = "corp-netapp-test-01-disk"
    location      = "eastus2"
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
        subnet_key                    = "subnet-netapp-test-01"
      }
    }
    resource_group_name  = "rg-netapp-test-01"
    size                 = "Standard_D4s_v3"
    sku                  = "2019-datacenter-gensecond"
    storage_account_type = "Premium_LRS"
    tags                 = { Domain = "parsons.com" }
    timezone             = "Eastern Standard Time"
    virtual_network      = "vnet-netapp-test-01"
    zone                 = 1
  }
}
