storage_accounts = {
  "storageprojectwisebackup" = {
    access_tier              = "Cool"
    account_kind             = "StorageV2"
    account_replication_type = "LRS"
    account_tier             = "Standard"
    location                 = "eastus2"
    network_rules = {
      ip_rules = ["209.128.255.129"] # Sterling (Commercial)
    }
    # Cohesity's archive target doesn't support using a storage account's private endpoint
    public_network_access_enabled = true
    resource_group_name           = "rg-infraops-prod-01"
  }
  "stparsonstfstatecomm" = {
    account_replication_type = "LRS"
    account_tier             = "Standard"
    containers = {
      tfstate = { # Used by tf_terragrunt
        container_access_type = "private"
      }
      platform-tfstate = { # Used by tf_platform_terragrunt
        container_access_type = "private"
      }
    }
    location            = "eastus2"
    resource_group_name = "rg-infraops-prod-01"
  }
}
