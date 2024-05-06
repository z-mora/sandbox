terraform {
  required_providers {
    aws = {
      configuration_aliases = [aws.support_account]
      source                = "hashicorp/aws"
      version               = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}
