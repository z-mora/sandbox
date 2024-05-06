palo_altos = {
  "vaser01pafw01" = {
    app_insights_settings = {
      name = "vaser01pafw01"
    }
    img_version = "10.1.5"
    interfaces = [
      {
        name        = "interface-palo_management-prod-01"
        subnet_name = "subnet-palo_management-prod-01"
        vnet_name   = "vnet-firewall-prod-01"
      },
      {
        create_public_ip = true
        name             = "interface-palo_untrust-prod-01"
        subnet_name      = "subnet-palo_untrust-prod-01"
        vnet_name        = "vnet-firewall-prod-01"
      },
      {
        name        = "interface-palo_trust-prod-01"
        subnet_name = "subnet-palo_trust-prod-01"
        vnet_name   = "vnet-firewall-prod-01"
      },
    ]
    location            = "eastus2"
    os_disk_name        = "disk-vaser01pafw-01"
    password            = ""
    public_ip_zones     = [1, 2, 3]
    resource_group_name = "rg-network-prod-01"
    username            = "panadmin"
    vm_size             = "Standard_D3_v2"
    vm_zone             = 1
  }
  "vaser01pafw02" = {
    app_insights_settings = {
      name = "vaser01pafw02"
    }
    img_version = "10.1.5"
    interfaces = [
      {
        name        = "interface-palo_management-prod-02"
        subnet_name = "subnet-palo_management-prod-01"
        vnet_name   = "vnet-firewall-prod-01"
      },
      {
        create_public_ip = true
        name             = "interface-palo_untrust-prod-02"
        subnet_name      = "subnet-palo_untrust-prod-01"
        vnet_name        = "vnet-firewall-prod-01"
      },
      {
        name        = "interface-palo_trust-prod-02"
        subnet_name = "subnet-palo_trust-prod-01"
        vnet_name   = "vnet-firewall-prod-01"
      },
    ]
    location            = "eastus2"
    os_disk_name        = "disk-vaser01pafw-02"
    password            = ""
    public_ip_zones     = [1, 2, 3]
    resource_group_name = "rg-network-prod-01"
    username            = "panadmin"
    vm_size             = "Standard_D3_v2"
    vm_zone             = 2
  }
}
