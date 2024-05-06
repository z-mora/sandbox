storage_accounts = {
  "storagensgflowlogsprod01" = {
    access_tier                   = "Hot"
    account_kind                  = "StorageV2"
    account_replication_type      = "LRS"
    account_tier                  = "Standard"
    location                      = "eastus2"
    public_network_access_enabled = true
    resource_group_name           = "rg-logging-prod-01"
  }
  "storagensgflwlogswestus2" = {
    access_tier                   = "Hot"
    account_kind                  = "StorageV2"
    account_replication_type      = "LRS"
    account_tier                  = "Standard"
    location                      = "westus2"
    public_network_access_enabled = true
    resource_group_name           = "rg-logging-prod-01"
  }
  "storagensgflwlgsuaenorth" = {
    access_tier                   = "Hot"
    account_kind                  = "StorageV2"
    account_replication_type      = "LRS"
    account_tier                  = "Standard"
    location                      = "uaenorth"
    public_network_access_enabled = true
    resource_group_name           = "rg-logging-prod-01"
  }
}
