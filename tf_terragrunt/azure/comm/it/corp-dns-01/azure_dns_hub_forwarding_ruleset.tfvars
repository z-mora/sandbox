dns_hub_forwarding_rulesets = {
  dnsfrs-hub-prod-eastus2-01 = {
    location             = "eastus2"
    private_resolver_key = "dnspr-prod-eastus2-01"
    resource_group_name  = "rg-dns-prod-01"
  }
  dnsfrs-hub-prod-westus2-01 = {
    location             = "westus2"
    private_resolver_key = "dnspr-prod-westus2-01"
    resource_group_name  = "rg-dns-prod-01"
  }
}
