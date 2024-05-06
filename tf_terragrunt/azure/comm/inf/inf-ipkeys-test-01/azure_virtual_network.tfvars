virtual_networks = {
  "vnet-ipkeys-test-01" = {
    cidr     = ["10.212.37.0/24"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-ipkeys-test-01" = {
        address_prefixes           = ["10.212.37.0/26"]
        network_security_group_key = "nsg-ipkeys-test-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-ipkeys-test-02" = {
        address_prefixes           = ["10.212.37.64/26"]
        network_security_group_key = "nsg-ipkeys-test-01"
      }
      "subnet-ipkeys-test-03" = {
        address_prefixes           = ["10.212.37.128/26"]
        network_security_group_key = "nsg-ipkeys-test-01"
      }
      "AzureBastionSubnet" = {
        address_prefixes           = ["10.212.37.192/26"]
        network_security_group_key = "nsg-ipkeys-test-bastion-01"
        service_endpoints          = []
      }
    }
    resource_group_name = "rg-ipkeys-test-01"
  }
}
