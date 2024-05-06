network_security_groups = {
  "nsg-ipkeys-test-01" = {
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
    resource_group_name = "rg-ipkeys-test-01"
  }
  "nsg-ipkeys-test-bastion-01" = {
    flowlogs_enable              = true
    flowlogs_resource_group_name = "rg-logging-prod-01"
    flowlogs_retention_days      = 7
    flowlogs_retention_enable    = true
    flowlogs_storageaccount_id   = "storagensgflowlogsprod01"
    flowlogs_subscription_id     = "a33caf97-919e-4d9c-914d-3634cc6c5d09"
    location                     = "eastus2"
    rules = {
      "AllowAzureCloudOutbound" = {
        access                     = "Allow"
        description                = "AllowAzureCloudOutbound"
        destination_address_prefix = "AzureCloud"
        destination_port_range     = "443"
        direction                  = "Outbound"
        priority                   = 110
        protocol                   = "Tcp"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }
      "AllowAzureLoadBalancerInbound" = {
        access                     = "Allow"
        description                = "AllowAzureLoadBalancerInbound"
        destination_address_prefix = "*"
        destination_port_range     = "443"
        direction                  = "Inbound"
        priority                   = 140
        protocol                   = "Tcp"
        source_address_prefix      = "AzureLoadBalancer"
        source_port_range          = "*"
      }
      "AllowBastionCommunicationOut5701" = {
        access                     = "Allow"
        description                = "AllowBastionCommunication"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "5701"
        direction                  = "Outbound"
        priority                   = 121
        protocol                   = "*"
        source_address_prefix      = "VirtualNetwork"
        source_port_range          = "*"
      }
      "AllowBastionCommunicationOut8080" = {
        access                     = "Allow"
        description                = "AllowBastionCommunication"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "8080"
        direction                  = "Outbound"
        priority                   = 120
        protocol                   = "*"
        source_address_prefix      = "VirtualNetwork"
        source_port_range          = "*"
      }
      "AllowBastionHostCommunicationIn5701" = {
        access                     = "Allow"
        description                = "AllowBastionHostCommunication"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "5701"
        direction                  = "Inbound"
        priority                   = 151
        protocol                   = "*"
        source_address_prefix      = "VirtualNetwork"
        source_port_range          = "*"
      }
      "AllowBastionHostCommunicationIn8080" = {
        access                     = "Allow"
        description                = "AllowBastionHostCommunication"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "8080"
        direction                  = "Inbound"
        priority                   = 150
        protocol                   = "*"
        source_address_prefix      = "VirtualNetwork"
        source_port_range          = "*"
      }
      "AllowGatewayManagerInbound" = {
        access                     = "Allow"
        description                = "AllowGatewayManagerInbound"
        destination_address_prefix = "*"
        destination_port_range     = "443"
        direction                  = "Inbound"
        priority                   = 130
        protocol                   = "Tcp"
        source_address_prefix      = "GatewayManager"
        source_port_range          = "*"
      }
      "AllowHttpOutbound" = {
        access                     = "Allow"
        description                = "AllowHttpOutbound"
        destination_address_prefix = "Internet"
        destination_port_range     = "80"
        direction                  = "Outbound"
        priority                   = 130
        protocol                   = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }
      "AllowHttpsInbound" = {
        access                     = "Allow"
        description                = "AllowHttpsInbound"
        destination_address_prefix = "*"
        destination_port_range     = "443"
        direction                  = "Inbound"
        priority                   = 120
        protocol                   = "Tcp"
        source_address_prefix      = "Internet"
        source_port_range          = "*"
      }
      "AllowRdpOutbound" = {
        access                     = "Allow"
        description                = "AllowRdpOutbound"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "3389"
        direction                  = "Outbound"
        priority                   = 101
        protocol                   = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }
      "AllowSshOutbound" = {
        access                     = "Allow"
        description                = "AllowSshOutbound"
        destination_address_prefix = "VirtualNetwork"
        destination_port_range     = "22"
        direction                  = "Outbound"
        priority                   = 100
        protocol                   = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
      }
    }
    resource_group_name = "rg-ipkeys-test-01"
  }
}
