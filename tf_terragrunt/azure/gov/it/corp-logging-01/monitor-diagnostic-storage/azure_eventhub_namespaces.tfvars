eventhub_namespaces = {
  "ehubspace-logging-prod-01" = {
    auto_inflate_enabled = false
    capacity             = 2
    eventhubs = {
      "ehub-activity-logs-prod-01" = {
        message_retention = 7
        partition_count   = 2
      }
    }
    location                      = "usgovvirginia"
    maximum_throughput_units      = 10
    public_network_access_enabled = true
    resource_group_name           = "rg-logging-prod-01"
    sku                           = "Standard"
  }
}
