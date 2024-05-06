network_security_groups = {
  "nsg-njatms-dev-01" = {
    location                     = "eastus2"
    resource_group_name          = "rg-njatms-dev-01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_enable              = true
    flowlogs_retention_enable    = true
    flowlogs_retention_days      = 7
    rules = {
      "allow-10.0.0.0" = {
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.0.0/8"
        destination_address_prefix = "*"
        description                = "Allow-10.0.0.0"
      }
      "allow-172.16.0.0" = {
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.16.0.0/12"
        destination_address_prefix = "*"
        description                = "Allow-172.16.0.0"
      }
    }
  }
}
