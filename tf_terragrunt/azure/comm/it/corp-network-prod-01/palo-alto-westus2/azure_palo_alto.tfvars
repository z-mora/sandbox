palo_altos = {
  "waser01pafw01" = {
    img_version = "10.1.8"
    interfaces = [
      {
        name        = "interface-palo_management-prod-1"
        subnet_name = "subnet-westus2-palo_management-prod-01"
        vnet_name   = "vnet-westus2-firewall-prod-01"
      },
      {
        create_public_ip = true
        name             = "interface-palo_untrust-prod-1"
        subnet_name      = "subnet-westus2-palo_untrust-prod-01"
        vnet_name        = "vnet-westus2-firewall-prod-01"
      },
      {
        name        = "interface-palo_trust-prod-1"
        subnet_name = "subnet-westus2-palo_trust-prod-01"
        vnet_name   = "vnet-westus2-firewall-prod-01"
      },
    ]
    location            = "westus2"
    password            = ""
    resource_group_name = "rg-network-prod-01"
    username            = "panadmin"
    vm_size             = "Standard_DS3_v2"
    vm_zone             = 1
  }
  "waser01pafw02" = {
    img_version = "10.1.8"
    interfaces = [
      {
        name        = "interface-palo_management-prod-2"
        subnet_name = "subnet-westus2-palo_management-prod-01"
        vnet_name   = "vnet-westus2-firewall-prod-01"
      },
      {
        create_public_ip = true
        name             = "interface-palo_untrust-prod-2"
        subnet_name      = "subnet-westus2-palo_untrust-prod-01"
        vnet_name        = "vnet-westus2-firewall-prod-01"
      },
      {
        name        = "interface-palo_trust-prod-2"
        subnet_name = "subnet-westus2-palo_trust-prod-01"
        vnet_name   = "vnet-westus2-firewall-prod-01"
      },
    ]
    location            = "westus2"
    password            = ""
    resource_group_name = "rg-network-prod-01"
    username            = "panadmin"
    vm_size             = "Standard_DS3_v2"
    vm_zone             = 2
  }
}
