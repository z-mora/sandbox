private_dns_resolvers = {
  dnspr-prod-eastus2-01 = {
    inbound_subnet_key  = "subnet-int-dns-inbound-prod-eastus2-01"
    location            = "eastus2"
    outbound_subnet_key = "subnet-int-dns-outbound-prod-eastus2-02"
    resource_group_name = "rg-dns-prod-01"
    vnet_key            = "vnet-int-dns-prod-eastus2-01"
  }
  dnspr-prod-westus2-01 = {
    inbound_subnet_key  = "subnet-int-dns-inbound-prod-westus2-01"
    location            = "westus2"
    outbound_subnet_key = "subnet-int-dns-outbound-prod-westus2-02"
    resource_group_name = "rg-dns-prod-01"
    vnet_key            = "vnet-int-dns-prod-westus2-01"
  }
}
