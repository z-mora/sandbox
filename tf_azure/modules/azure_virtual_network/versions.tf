terraform {
  required_providers {
    azurerm = {
      configuration_aliases = [azurerm.corp_network, azurerm.dns_hub]
      source                = "hashicorp/azurerm"
      version               = ">= 3.57"
    }
  }
  required_version = ">= 1.5.0"
}
