private_dns_resolvers = {
  dnspr-prod-usgovvirginia-01 = {
    inbound_subnet_key  = "subnet-int-dns-inbound-prod-usgovvirginia-01"
    location            = "usgovvirginia"
    outbound_subnet_key = "subnet-int-dns-outbound-prod-usgovvirginia-02"
    resource_group_name = "rg-dns-prod-01"
    vnet_key            = "vnet-int-dns-prod-usgovvirginia-01"
  }
}
