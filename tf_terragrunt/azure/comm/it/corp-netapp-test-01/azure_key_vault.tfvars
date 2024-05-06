key_vaults = {
  "corp-netapp-test-01-disk" = {
    enable_rbac_authorization     = true
    enabled_for_disk_encryption   = true
    location                      = "eastus2"
    public_network_access_enabled = true
    purge_protection_enabled      = true
    resource_group_name           = "rg-netapp-test-01"
    soft_delete_retention_days    = 7
  }
}
