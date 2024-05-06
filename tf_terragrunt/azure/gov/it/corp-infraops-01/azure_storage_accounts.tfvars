storage_accounts = {
  "stparsonstfstategov" = {
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
    network_rules = {
      ip_rules = [
        "206.219.248.2",   # PADC (Commercial)
        "206.219.248.14",  # PADC (Federal)
        "86.96.199.209",   # MEDC (Commercial)
        "157.185.39.254",  # Centreville (Federal)
        "157.185.60.254",  # Huntsville (Federal)
        "63.238.47.11",    # Colorado Springs (Federal)
        "15.184.10.142",   # Bahrain1 (Commercial)
        "15.184.9.135",    # Bahrain2 (Commercial)
        "209.128.255.129", # Sterling (Commercial)
        "209.128.255.130", # Sterling (Federal)
        "209.128.239.129", # Denver (Commercial)
        "209.128.239.130", # Denver (Federal)
        "209.128.239.141", # Denver (LAB)
        "3.99.11.7",       # Montreal1 (Commercial)
        "3.96.83.233",     # Montreal2 (Commercial)
      ]
    }
    # Terraform's azurerm backend doesn't support using a storage account's private endpoint
    public_network_access_enabled = true
    location                      = "usgovvirginia"
    resource_group_name           = "rg-infraops-prod-01"
  }
}
