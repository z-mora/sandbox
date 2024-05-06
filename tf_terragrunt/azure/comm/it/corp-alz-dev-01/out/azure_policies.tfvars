# policies = {
#   "policy-nist-sp-800-171-rev-2" = {
#     policy_assignment = {
#       name                                    = "assignment-nist-sp-800-171-rev-2"
#       management_group_policy_assignment_name = "nist-800-171-r2"
#       description                             = "This initiative includes policies that address a subset of NIST SP 800-171 Rev. 2 requirements. Policies may be added or removed in future releases. For more information, visit https://aka.ms/nist800171r2-initiative."
#       enforce                                 = false
#       parameters                              = ""
#       management_group_name                   = "mg-network-prod-01"
#     },
#     policy_initiative = {
#       name                  = "initiative-nist-sp-800-171-rev-2"
#       policy_type           = "Custom"
#       display_name          = "initiative-nist-sp-800-171-rev-2"
#       management_group_name = "Tenant Root Group"
#       policy_definitions = [
#         "3cf2ab00-13f1-4d0c-8971-2ac904541a7e",
#         "0088bc63-6dee-4a9c-9d29-91cfdc848952"
#       ]
#     }
#   }
# }


policies = {
  "policy-nist-sp-800-171-rev-2" = {
    initiative_definition_name = "NIST SP 800-171 Rev. 2"
    policy_assignments = {
      "assignment-example" = {
        enforce         = false
        initiative_name = "NIST SP 800-171 Rev. 2"
        scope           = "sub"
        scope_id        = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
      }
    }
    policy_exemptions = {
      "exemption-example" = {
        assignment_name = "assignment-example"
        category        = "Mitigated"
        scope           = "rg"
        scope_id        = "/subscriptions/d5fb8c13-907c-4c33-8021-d5457490856b/resourceGroups/rg-cps-prod-01"
      }
    }
  }
}