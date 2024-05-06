locals {
  corp_firewall_vnet_name = (
    var.location == "eastus2" || var.location == "usgovvirginia" ?
    "vnet-firewall-prod-01" : "vnet-${var.location}-firewall-prod-01"
  )
  service_endpoints = concat(
    strcontains(var.location, "gov") ? [] : ["Microsoft.AzureActiveDirectory"],
    [
      "Microsoft.CognitiveServices",
      "Microsoft.ContainerRegistry",
      "Microsoft.EventHub",
      "Microsoft.KeyVault",
      "Microsoft.ServiceBus",
      "Microsoft.Sql",
      "Microsoft.Storage",
      "Microsoft.Web"
  ])

  default_dns_servers = (
    var.is_dmz == true ? null : (
    var.is_gov ? ["10.33.254.16", "10.33.254.76"] : ["10.0.4.16", "10.0.4.18"])
  )
}
