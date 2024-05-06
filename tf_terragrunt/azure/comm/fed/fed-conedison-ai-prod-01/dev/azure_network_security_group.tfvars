network_security_groups = {
  "nsg-conedison-ai-dev-01" = {
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
    resource_group_name = "rg-conedison-ai-dev-01"
  }
  "nsg-conedison-ai-dev-appgw-01" = {
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
        destination_port_range     = "65200-65535"
        direction                  = "Inbound"
        priority                   = 110
        protocol                   = "*"
        source_address_prefix      = "GatewayManager"
        source_port_range          = "*"
      }
      "allow-internet-health-probes" = {
        access                     = "Allow"
        description                = "Allow-Internet-Health-Probes"
        destination_address_prefix = "*"
        destination_port_range     = "65200-65535"
        direction                  = "Inbound"
        priority                   = 111
        protocol                   = "*"
        source_address_prefix      = "Internet"
        source_port_range          = "*"
      }
      "deny-internet-to-public-ip" = {
        access                     = "Deny"
        description                = "Deny-Internet-Inbound"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 4096
        protocol                   = "*"
        source_address_prefix      = "Internet"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-conedison-ai-dev-01"
  }
}
