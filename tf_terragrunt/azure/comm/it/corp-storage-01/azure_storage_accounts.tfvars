storage_accounts = {
  "stpowerbisevenprogram" = {
    account_kind                    = "StorageV2"
    account_replication_type        = "LRS"
    account_tier                    = "Standard"
    allow_nested_items_to_be_public = true
    location                        = "eastus2"
    # The PowerBI reports pulling images from this storage account will be accessed by
    # users outside of Parsons
    public_network_access_enabled = true
    resource_group_name           = "rg-storage-prod-01"
    tags = {
      Owner = "mohamed.sabbah@parsons.com"
    }
  }
}
