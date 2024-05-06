dns_hub_private_link_dns_zones = {
  resource_group_name = "rg-dns-prod-01"
  vnet_keys = [
    "vnet-int-dns-prod-eastus2-01",
    "vnet-int-dns-prod-westus2-01",
  ]
}
