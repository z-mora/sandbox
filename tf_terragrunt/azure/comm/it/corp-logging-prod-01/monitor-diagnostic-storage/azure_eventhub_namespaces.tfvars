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
    location                      = "eastus2"
    public_network_access_enabled = true
    maximum_throughput_units      = 10
    resource_group_name           = "rg-logging-prod-01"
    sku                           = "Standard"
  }
  "ehubspace-logging-prod-02" = {
    auto_inflate_enabled = false
    capacity             = 2
    eventhubs = {
      "ehub-activity-logs-prod-02" = {
        message_retention = 7
        partition_count   = 2
      }
    }
    location                      = "westus2"
    public_network_access_enabled = true
    maximum_throughput_units      = 10
    resource_group_name           = "rg-logging-prod-01"
    sku                           = "Standard"
  }
  "ehubspace-logging-prod-03" = {
    auto_inflate_enabled = false
    capacity             = 2
    eventhubs = {
      "ehub-activity-logs-prod-03" = {
        message_retention = 7
        partition_count   = 2
      }
    }
    location                      = "uaenorth"
    public_network_access_enabled = true
    maximum_throughput_units      = 10
    resource_group_name           = "rg-logging-prod-01"
    sku                           = "Standard"
  }
}
