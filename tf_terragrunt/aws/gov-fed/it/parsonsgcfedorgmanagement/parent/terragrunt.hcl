include "root" {
  path = find_in_parent_folders("aws.hcl")
}

inputs = {
  organization = {
    aws_service_access_principals = [
      "account.amazonaws.com",
      "cloudtrail.amazonaws.com",
      "compute-optimizer.amazonaws.com",
      "config.amazonaws.com",
      "guardduty.amazonaws.com",
      "member.org.stacksets.cloudformation.amazonaws.com",
      "ram.amazonaws.com",
      "securityhub.amazonaws.com",
      "servicecatalog.amazonaws.com",
      "sso.amazonaws.com"
    ]
    enabled_policy_types = [
      "SERVICE_CONTROL_POLICY"
    ]

    organizational_units = {
      "Root" = {
        "GovCloud" = {
          "GovCloudParents" = {}
        }
        "Suspended" = {}
      }
    }
    policies = {}
  }
}
