locals {
  # Convert HCL policy to string, replace CloudFormation pseudo parameters, and then
  # convert back to HCL
  policy_hcl = var.policy_hcl == null ? null : jsondecode(
    replace(
      replace(
        replace(
          replace(
            replace(jsonencode(var.policy_hcl), "!Sub", ""),
            "$${AWS::AccountId}", var.current_account_id
          ),
          "$${AWS::NoValue}", "null"
        ),
        "$${AWS::Partition}", var.current_partition
      ),
      "$${AWS::Region}", var.current_region
    )
  )
  # Replace CloudFormation psuedo params before converting YAML to HCL
  policy_yaml_as_hcl = var.policy_yaml == null ? null : yamldecode(
    replace(
      replace(
        replace(
          replace(
            replace(var.policy_yaml, "!Sub", ""),
            "$${AWS::AccountId}", var.current_account_id
          ),
          "$${AWS::NoValue}", "null"
        ),
        "$${AWS::Partition}", var.current_partition
      ),
      "$${AWS::Region}", var.current_region
    )
  )
  # Rename "JobWbs" to "Job/Wbs", can't have "/" in object attribute type definition
  tags = var.tags == null ? null : merge(
    { for k, v in var.tags : k => v if k != "JobWbs" },
    { "Job/Wbs" = var.tags["JobWbs"] }
  )
}
