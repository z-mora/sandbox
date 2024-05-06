virtual_networks = {
  "vnet-cps-prod-01" = {
    cidr     = ["10.208.64.0/23"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-cps-prod-01" = {
        address_prefixes           = ["10.208.64.0/24"]
        network_security_group_key = "nsg-cps-prod-01"
        service_endpoints = [
          "Microsoft.AzureActiveDirectory",
          "Microsoft.Storage"
        ]
      }
    }
    resource_group_name = "rg-cps-prod-01"
  }
}
