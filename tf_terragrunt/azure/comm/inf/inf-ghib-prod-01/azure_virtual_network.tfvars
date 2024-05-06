virtual_networks = {
  "vnet-ghib-prod-01" = {
    cidr     = ["10.212.10.0/24"]
    is_dmz   = true
    location = "eastus2"
    private_subnets = {
      "subnet-ghib-prod-01" = {
        address_prefixes           = ["10.212.10.0/26"]
        network_security_group_key = "nsg-ghib-prod-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-ghib-prod-02" = {
        address_prefixes           = ["10.212.10.64/26"]
        network_security_group_key = "nsg-ghib-prod-01"
      }
      "subnet-ghib-prod-03" = {
        address_prefixes           = ["10.212.10.128/26"]
        network_security_group_key = "nsg-ghib-prod-01"
      }
      "subnet-ghib-prod-04" = {
        address_prefixes           = ["10.212.10.192/26"]
        network_security_group_key = "nsg-ghib-prod-01"
      }
    }
    resource_group_name = "rg-ghib-prod-01"
  }
}
