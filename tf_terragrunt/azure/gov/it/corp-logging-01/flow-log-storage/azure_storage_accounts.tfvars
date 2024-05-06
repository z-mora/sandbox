storage_accounts = {
  "storagensgflowlogsprod01" = {
    access_tier                   = "Hot"
    account_kind                  = "StorageV2"
    account_replication_type      = "LRS"
    account_tier                  = "Standard"
    location                      = "usgovvirginia"
    public_network_access_enabled = true
    resource_group_name           = "rg-logging-prod-01"
  }
}
