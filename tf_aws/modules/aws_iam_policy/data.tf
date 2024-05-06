# It's not required to use this data source to generate a JSON policy, but it is best practice
# See: https://developer.hashicorp.com/terraform/tutorials/aws/aws-iam-policy#refactor-your-policy

data "aws_iam_policy_document" "from_hcl" {
  count = var.policy_hcl == null ? 0 : 1

  version = local.policy_hcl.version

  dynamic "statement" {
    for_each = local.policy_hcl.statements
    content {
      actions   = statement.value.actions
      effect    = statement.value.effect
      resources = statement.value.resources
      sid       = statement.key
    }
  }
}

data "aws_iam_policy_document" "from_yaml" {
  count = var.policy_yaml == null ? 0 : 1

  # yamldecode() converts the version to a timestamp, set it back to the proper format
  version = formatdate("YYYY-MM-DD", local.policy_yaml_as_hcl.Version)

  dynamic "statement" {
    for_each = local.policy_yaml_as_hcl.Statement
    content {
      actions = statement.value.Action
      effect  = statement.value.Effect
      # Resource may be a list of strings or a string, depending on the YAML
      # Ensure we pass a list of strings
      resources = try(split(", ", statement.value.Resource), statement.value.Resource)
      sid       = try(statement.value.Sid, null)
    }
  }
}
