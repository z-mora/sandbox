network_security_groups = {
  "nsg-int-netapp-prod-usgovvirginia-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "19b154c8-1d33-40a6-8454-f48d7fc08db8"
    location                     = "usgovvirginia"
    rules = {
      "allow-10.0.0.0" = {
        access                     = "Allow"
        description                = "Allow-10.0.0.0"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "10.0.0.0/8"
        source_port_range          = "*"
      }
      "allow-172.16.0.0" = {
        access                     = "Allow"
        description                = "Allow-172.16.0.0"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 101
        protocol                   = "*"
        source_address_prefix      = "172.16.0.0/12"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-netapp-prod-01"
  }
}
