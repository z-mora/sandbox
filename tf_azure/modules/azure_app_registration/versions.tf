terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.42"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}
