dependency "parent" {
  config_path = "../parent"
  mock_outputs = {
    govcloud_account_id = "132099164706" # ParsonsFedGCServiceCatalogToolsProd
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "show", "terragrunt-info"]
}

# Until Terraform 1.6 is released, we need to generate the import block because the
# resource ID to import needs to be a static string when Terraform runs
generate "import" {
  path      = "import.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    import {
      to = module.aws_account[0].aws_organizations_account.this
      id = "${dependency.parent.outputs.govcloud_account_id}"
    }
  EOF
}

include "root" {
  path = find_in_parent_folders("aws.hcl")
}
