provider "aws" {
  alias  = "current_account"
  region = var.region
  assume_role {
    duration     = "1h"
    role_arn     = "arn:${data.aws_partition.current.partition}:iam::${local.account_id}:role/service-role/_sys_terragrunt_admin_role"
    session_name = "terraform-${var.username}"
  }
  profile = var.profile
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "management_account"
  region = var.sso_region
  assume_role {
    duration     = "1h"
    role_arn     = var.management_account_role
    session_name = "terraform-${var.username}"
  }
  profile = var.profile
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "network_account"
  region = var.region
  assume_role {
    duration     = "1h"
    role_arn     = "arn:${data.aws_partition.current.partition}:iam::${var.network_account_id}:role/service-role/_sys_terragrunt_admin_role"
    session_name = "terraform-${var.username}"
  }
  profile = var.profile
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias   = "support_account"
  profile = "oce-ss"
  region  = "us-east-1"
  assume_role {
    duration     = "1h"
    role_arn     = "arn:aws:iam::100244082598:role/service-role/_sys_terragrunt_admin_role"
    session_name = "terraform-${var.username}"
  }
  default_tags {
    tags = local.default_tags
  }
}

provider "vault" {
  address = "https://hcvault.parsons.us"
  # token = gets set via the VAULT_TOKEN environment variable

  # We currently don't have permission to generate ephemeral child tokens
  skip_child_token = true
}
