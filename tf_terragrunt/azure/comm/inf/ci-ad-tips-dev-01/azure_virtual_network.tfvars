virtual_networks = {
  "vnet-ad-tips-dev-01" = {
    # Disable because the appgw subnet doesn't have appgw in the name
    auto_create_dmz_route_table = false
    cidr                        = ["10.212.8.0/23"]
    is_dmz                      = true
    location                    = "eastus2"
    private_subnets = {
      "subnet-ad-tips-dev-01" = {
        address_prefixes           = ["10.212.8.0/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-02" = {
        address_prefixes           = ["10.212.8.64/26"]
        network_security_group_key = "nsg-ad-tips-dev-appgw-01"
        route_table_key            = "rt-ad-tips-dev-appgw-01"
      }
      "subnet-ad-tips-dev-03" = {
        address_prefixes           = ["10.212.8.128/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-04" = {
        address_prefixes           = ["10.212.8.192/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-05" = {
        address_prefixes           = ["10.212.9.0/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-06" = {
        address_prefixes           = ["10.212.9.64/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-07" = {
        address_prefixes           = ["10.212.9.128/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
      "subnet-ad-tips-dev-08" = {
        address_prefixes           = ["10.212.9.192/26"]
        network_security_group_key = "nsg-ad-tips-dev-01"
        route_table_key            = "rt-ad-tips-dev-01"
      }
    }
    resource_group_name = "rg-ad-tips-dev-01"
  }
}
