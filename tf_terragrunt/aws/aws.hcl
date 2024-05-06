# This is the AWS Terragrunt config used by every AWS Terragrunt module.
# For more info about Terragrunt see: https://confluence.parsons.com/x/xQFgCw

locals {
  # Grab the branch specifier from Jenkins env var
  branch = get_env("TERRAFORM_BRANCH", "main")
  dir    = get_terragrunt_dir()
  # The parent is in the commercial partition, so only the child is considered GovCloud
  is_gov_child  = strcontains(local.dir, "gov") && strcontains(local.dir, "child")
  is_gov_parent = strcontains(local.dir, "gov") && strcontains(local.dir, "parent")
  is_jenkins    = try(get_env("USER") == "jenkins", false)
  local_source  = get_platform() == "windows" ? "C:/dev/code/cm/tf_aws" : "/code/cm/tf_aws"
  remote_source = "git::ssh://git@git.parsons.com:7999/cm/tf_aws.git//?ref=${local.branch}"
  s3_profile    = local.is_gov_child ? "pce-ss" : "oce-ss"
  s3_region     = local.is_gov_child ? "us-gov-east-1" : "us-east-1"
}

inputs = {
  is_jenkins = local.is_jenkins
  username   = get_env("USER_SHORT", "jenkins")
}

# State files for deployments in the Commercial partition are stored in Corp IT Commercial Shared Services
# State files for deployments in the GovCloud partition are stored in Corp IT GovCloud Shared Services
# TODO - Enable state locking - STAR-10908
remote_state {
  backend = "s3"
  config = {
    bucket         = "parsons-terraform-state"
    dynamodb_table = "terraform-state-lock"
    dynamodb_table_tags = {
      App         = "N/A"
      Environment = "PROD"
      GBU         = "COR"
      ITSM        = "MANAGEMENT"
      JobWbs      = "897720-01101"
      Owner       = "infraopscloud@parsons.com"
    }
    encrypt = true
    key     = "aws/${path_relative_to_include()}/terraform.tfstate"
    profile = local.s3_profile
    region  = local.s3_region
  }
}

terraform {
  source = local.is_jenkins ? local.remote_source : local.local_source

  extra_arguments "var_files" {
    commands = get_terraform_commands_that_need_vars()

    # optional var files can override required, but if you try to override one optional
    # var file with another you'll probably see inconsistent results
    required_var_files = [
      try(
        find_in_parent_folders("common.tfvars"),
        local.is_gov_child ? find_in_parent_folders("common_child.tfvars") :
        find_in_parent_folders("common_parent.tfvars")
      ),
    ]

    optional_var_files = [
      "${get_terragrunt_dir()}/aws_account.tfvars",
      "${get_terragrunt_dir()}/aws_customer_gateway.tfvars",
      "${get_terragrunt_dir()}/aws_iam.tfvars",
      "${get_terragrunt_dir()}/aws_iam_group.tfvars",
      "${get_terragrunt_dir()}/aws_iam_policy.tfvars",
      "${get_terragrunt_dir()}/aws_iam_user.tfvars",
      "${get_terragrunt_dir()}/aws_lb.tfvars",
      "${get_terragrunt_dir()}/aws_ssm.tfvars",
      "${get_terragrunt_dir()}/aws_tgw_route_table.tfvars",
      "${get_terragrunt_dir()}/aws_tgw.tfvars",
      "${get_terragrunt_dir()}/aws_vpc.tfvars",
      "${get_terragrunt_dir()}/aws_organization.tfvars",
      "${get_terragrunt_dir()}/default.tfvars",
    ]
  }
}

terraform_version_constraint  = ">= 1.5, < 1.6"
terragrunt_version_constraint = ">= 0.48"

retry_max_attempts       = 6
retry_sleep_interval_sec = 30

# Made regex case-insensitive to account for the case ever changing, as
# AWS errors are thrown with inconsistent cases
retryable_errors = [
  # Error thrown when creating filter and log group isn't available yet
  "(?is).*Error.*Cloudwatch.*filter.*ValidationException.*permission.*",
  # Error thrown when creating routes and TGW attachment isn't accepted/available yet
  "(?is).*error creating route.*InvalidTransitGatewayID.NotFound.*",
  # Error thrown when AWS account delete doesn't occur immediately
  "(?is).*waiting for AWS.*Account.*delete.*unexpected state.*",
  # These errors seem related to the Terragrunt role not being available yet
  "(?is).*fetching Availability Zones: UnauthorizedOperation.*",
  "(?is).*failed to refresh cached credentials.*_sys_terragrunt_admin_role.*",
  "(?is).*terragrunt_admin_role.*cannot be assumed.*",
  "(?is).*Cannot assume IAM Role.*",
  "(?is).*_sys_terragrunt_admin_role.*is not authorized to perform.*",
  # Error thrown when state file already in use and locked
  "(?is).*Error acquiring the state lock.*",
]
