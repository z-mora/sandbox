provider "azuread" {
  environment = var.environment
}

provider "azurerm" {
  environment                = var.environment
  skip_provider_registration = true
  subscription_id            = var.subscription_id

  features {}
}

provider "azurerm" {
  alias                      = "corp_network"
  environment                = var.environment
  skip_provider_registration = true
  subscription_id            = var.corp_network_subscription_id

  features {}
}

provider "azurerm" {
  alias                      = "dns_hub"
  environment                = var.environment
  skip_provider_registration = true
  subscription_id            = var.corp_dns_subscription_id

  features {}
}


provider "vault" {
  address = "https://hcvault.parsons.us"
  # token = gets set via the VAULT_TOKEN environment variable

  # We currently don't have permission to generate ephemeral child tokens
  skip_child_token = true
}
