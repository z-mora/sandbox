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
      "member.org.stacksets.cloudformation.amazonaws.com",
      "reporting.trustedadvisor.amazonaws.com",
      "servicecatalog.amazonaws.com",
      "sso.amazonaws.com"
    ]
    enabled_policy_types = [
      "SERVICE_CONTROL_POLICY"
    ]

    organizational_units = {
      "Root" = {
        "GovCloud" = {
          "GovCloudParents" = {
            policies = [
              "organizations_restrict",
              "restrict_root"
            ]
          }
        }
        "Suspended" = {}
      }
    }
    policies = {
      "organizations_restrict" = {
        description = "Prevents leaving the Organization."
        content     = file("organizations_restrict.json")
      }
      "restrict_root" = {
        description = "Denies Root from creating/reading/managing any resources in accounts."
        content     = file("restrict_root.json")
      }
      "suspend_account" = {
        description = "For accounts that are suspended/closed pending, only allow access to the Billing portal."
        content     = file("suspend_account.json")
      }
    }
  }

}
