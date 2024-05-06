virtual_networks = {
  "vnet-sap-poc-dev-01" = {
    cidr     = ["10.208.72.0/24", "10.208.83.0/24"]
    is_dmz   = false
    location = "eastus2"
    private_subnets = {
      "subnet-sap-poc-dev-01" = {
        address_prefixes           = ["10.208.72.0/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
      }
      "subnet-sap-poc-dev-02-function-app-splunk" = {
        address_prefixes           = ["10.208.72.64/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-03-azure-functions" = {
        address_prefixes           = ["10.208.72.128/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-04-azure-functions" = {
        address_prefixes           = ["10.208.72.192/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-05-function-app-workday" = {
        address_prefixes           = ["10.208.83.0/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-06-function-app-splunk-bidata" = {
        address_prefixes           = ["10.208.83.64/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "Microsoft.Web.serverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-07-function-app-adlogs-bidata" = {
        address_prefixes           = ["10.208.83.128/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
        delegation_name            = "MicrosoftWebserverFarms"
        delegation_service         = "Microsoft.Web/serverFarms"
        delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
      "subnet-sap-poc-dev-08" = {
        address_prefixes           = ["10.208.83.192/26"]
        network_security_group_key = "nsg-sap-poc-dev-01"
      }
    }
    resource_group_name = "rg-sap-poc-dev-01"
  }
}
