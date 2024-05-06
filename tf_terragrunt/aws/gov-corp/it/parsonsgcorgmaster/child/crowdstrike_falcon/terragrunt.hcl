include "root" {
  path = find_in_parent_folders("aws.hcl")
}

locals {
  is_vagrant    = get_env("USER") == "vagrant"
  local_source  = "/code/cm/tf_aws_crowdstrike_falcon/custom"
  remote_source = "git::ssh://git@git.parsons.com:7999/cm/tf_aws_crowdstrike_falcon.git//custom"
}

terraform {
  source = local.is_vagrant ? local.local_source : local.remote_source
}
