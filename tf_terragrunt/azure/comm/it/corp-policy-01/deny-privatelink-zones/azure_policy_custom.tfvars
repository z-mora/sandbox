

custom_policy_definitions = {
  "Parsons-Deny-PrivateDNSZone-PrivateLink" = {
    mode         = "All"
    display_name = "Parsons-Deny-PrivateDNSZone-PrivateLink"
    description  = "This policy restricts creation of private DNS zones with the `privatelink` prefix"
    policy_rule  = <<POLICY_RULE
      {
        "if": {
          "allOf": [
            {
              "field": "type",
              "equals": "Microsoft.Network/privateDnsZones"
            },
            {
              "field": "name",
              "contains": "privatelink."
            }
          ]
        },
        "then": {
          "effect": "Deny"
        }
          }
    POLICY_RULE
  }
}
