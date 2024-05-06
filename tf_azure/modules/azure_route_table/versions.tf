terraform {
  required_providers {
    azurerm = {
      configuration_aliases = [azurerm.corp_network]
      source                = "hashicorp/azurerm"
      version               = ">= 2.0"
    }
  }
  required_version = ">= 1.5.0"
}
