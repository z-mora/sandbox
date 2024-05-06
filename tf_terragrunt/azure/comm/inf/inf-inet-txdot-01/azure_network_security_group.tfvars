network_security_groups = {
  "nsg-dmz-inet-txdot-dev-eastus2-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "eastus2"
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
    resource_group_name = "rg-inet-txdot-dev-01"
  }
  "nsg-dmz-inet-appgw-txdot-dev-eastus2-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "eastus2"
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
      "allow-gatewaymanager-health-probes" = {
        access                     = "Allow"
        description                = "Allow-GatewayManager-Health-Probes"
        destination_address_prefix = "*"
        destination_port_range     = "65503-65534"
        direction                  = "Inbound"
        priority                   = 110
        protocol                   = "*"
        source_address_prefix      = "GatewayManager"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-inet-txdot-dev-01"
  }
}
