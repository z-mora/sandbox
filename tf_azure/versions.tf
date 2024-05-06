terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.42"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.57"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0, < 1.6"
}
