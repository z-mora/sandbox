# Since this account was created outside of Terraform and imported, the parent account
# doesn't have an attribute for govcloud_account_id
dependency "parent" {
  config_path = "../parent"
}

# Until Terraform 1.6 is released, we need to generate the import block because the
# resource ID to import needs to be a static string when Terraform runs
generate "import" {
  path      = "import.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    import {
      to = module.aws_account[0].aws_organizations_account.this
      id = 305662966459
    }
  EOF
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}
