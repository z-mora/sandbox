management_group_name = "mg-network-prod-01"

/* management_group_policy_assignments = {
  "initiative-nist-sp-800-171-rev-2" = {
    management_group_policy_assignment_name = "nist-800-171-r2"
    description                             = "COPY-This initiative includes policies that address a subset of NIST SP 800-171 Rev. 2 requirements. Policies may be added or removed in future releases. For more information, visit https://aka.ms/nist800171r2-initiative."
    enforce                                 = false
    parameters                              = ""
  }
} */

# Commenting out until ready to create custom policy definitions

# policy_definition_file_names = [
#   "policy-definition-01.json"
# ]

# policy_initiatives = {
#   "test-policydefinition-01" = {
#     policy_type  = "Custom"
#     display_name = "This is a test policy definition"
#     policy_definitions = [
#       "policy-definition-01",
#       "3cf2ab00-13f1-4d0c-8971-2ac904541a7e",
#       "0088bc63-6dee-4a9c-9d29-91cfdc848952"
#     ]
#   }
# }
