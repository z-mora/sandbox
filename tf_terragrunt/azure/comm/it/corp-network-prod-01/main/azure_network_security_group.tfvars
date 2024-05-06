network_security_groups = {
  "nsg-firewall_trust-prod-01" = {
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
    resource_group_name = "rg-network-prod-01"
  }
  "nsg-firewall_untrust-prod-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "eastus2"
    rules = {
      "allow-internet" = {
        access                     = "Allow"
        description                = "Allow-Internet"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "0.0.0.0/0"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
  "nsg-uaenorth-firewall_trust-prod-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflwlgsuaenorth"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "uaenorth"
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
    resource_group_name = "rg-network-prod-01"
  }
  "nsg-uaenorth-firewall_untrust-prod-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflwlgsuaenorth"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "uaenorth"
    rules = {
      "allow-internet" = {
        access                     = "Allow"
        description                = "Allow-Internet"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "0.0.0.0/0"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
  "nsg-westus2-firewall_trust-prod-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflwlogswestus2"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "westus2"
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
    resource_group_name = "rg-network-prod-01"
  }
  "nsg-westus2-firewall_untrust-prod-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflwlogswestus2"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "westus2"
    rules = {
      "allow-internet" = {
        access                     = "Allow"
        description                = "Allow-Internet"
        destination_address_prefix = "*"
        destination_port_range     = "*"
        direction                  = "Inbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "0.0.0.0/0"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-network-prod-01"
  }
}
