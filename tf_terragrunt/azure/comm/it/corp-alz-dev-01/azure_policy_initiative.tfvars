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

custom_policies = {
  "audit-tagging" = {
    initiative_definition_name = "audit_tagging"
    policy_assignments = {
      "audit_tagging" = {
        enforce               = true
        initiative_name       = "audit_tagging"
        management_group_name = "mg-infra-prod-01"
        scope                 = "sub"
        scope_id              = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
      }
    }
  },
  "audit-route" = {
    initiative_definition_name = "route_audit"
    policy_assignments = {
      "route_audit" = {
        enforce               = true
        initiative_name       = "route_audit"
        management_group_name = "mg-infra-prod-01"
        scope                 = "sub"
        scope_id              = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
      }
    }
  }
}



policy_assignments = {
  "Audit Public Network Access" = {
    built_in_assignments = {
      "Audit Public Network Access" = {
        name                   = "Audit Public Network Access"
        description            = "Audit Public Network Access"
        enforce                = true
        policy_definition_id   = "/providers/microsoft.authorization/policysetdefinitions/f1535064-3294-48fa-94e2-6e83095a5c08"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        parameters             = <<PARAMETERS
          {
            "Effect-Microsoft.AppConfiguration-configurationStores": {
              "value": "Deny"
            },
            "Effect-AppServiceEnvironment": {
              "value": "Deny"
            },
            "Effect-Microsoft.Attestation-attestationProviders": {
              "value": "Deny"
            },
            "Effect-Microsoft.Automation-automationAccounts": {
              "value": "Deny"
            },
            "Effect-Microsoft.Batch-batchAccounts": {
              "value": "Deny"
            },
            "Effect-Microsoft.BotService-botServices": {
              "value": "Deny"
            },
            "Effect-Microsoft.Cache-Redis": {
              "value": "Deny"
            },
            "Effect-Microsoft.CognitiveServices-accounts": {
              "value": "Deny"
            },
            "Effect-Microsoft.ContainerRegistry-registries": {
              "value": "Deny"
            },
            "Effect-Microsoft.DataFactory-factories": {
              "value": "Deny"
            },
            "Effect-Microsoft.DBforMariaDB-servers": {
              "value": "Deny"
            },
            "Effect-Microsoft.DBforMySQL-flexibleServers": {
              "value": "Deny"
            },
            "Effect-Microsoft.DBforMySQL-servers": {
              "value": "Deny"
            },
            "Effect-Microsoft.DBforPostgreSQL-flexibleServers": {
              "value": "Deny"
            },
            "Effect-Microsoft.DBforPostgreSQL-servers": {
              "value": "Deny"
            },
            "Effect-Microsoft.Databricks-workspaces": {
              "value": "Deny"
            },
            "Effect-Microsoft.Devices-IotHubs": {
              "value": "Deny"
            },
            "Effect-Microsoft.Devices-IotHubProvisioningService": {
              "value": "Deny"
            },
            "Effect-Microsoft.KeyVault-vaults": {
              "value": "Deny"
            },
            "Effect-Microsoft.DocumentDB-databaseAccounts": {
              "value": "Deny"
            },
            "Effect-Microsoft.EventGrid-domains": {
              "value": "Deny"
            },
            "Effect-Microsoft.EventGrid-topics": {
              "value": "Deny"
            },
            "Effect-Microsoft.HybridCompute-privateLinkScopes": {
              "value": "Deny"
            },
            "Effect-Microsoft.Insights-applicationInsights": {
              "value": "Deny"
            },
            "Effect-AzureMonitorPrivateLinkScopes": {
              "value": "Deny"
            },
            "Effect-Microsoft.MachineLearningServices-workspaces": {
              "value": "Deny"
            },
            "Effect-Microsoft.Media-mediaServices": {
              "value": "Deny"
            },
            "Effect-Microsoft.OperationalInsights-LogAnalytics": {
              "value": "Deny"
            },
            "Effect-Microsoft.Search-searchServices": {
              "value": "Deny"
            },
            "Effect-Microsoft.ServiceBus-namespaces": {
              "value": "Deny"
            },
            "Effect-Microsoft.SignalRService-SignalR": {
              "value": "Deny"
            },
            "Effect-Microsoft.SignalRService-webPubSub": {
              "value": "Deny"
            },
            "Effect-Microsoft.SQL-servers": {
              "value": "Deny"
            },
            "Effect-Microsoft.Storage-storageAccounts": {
              "value": "Deny"
            },
            "Effect-Microsoft.Synapse-workspaces": {
              "value": "Deny"
            }
          }
          PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Enable audit category group resource logging" = {
    built_in_assignments = {
      "Enable audit category group resource logging" = {
        name                   = "Enable audit category group resource logging"
        description            = "Enable audit category group resource logging"
        enforce                = true
        policy_definition_id   = "/providers/microsoft.authorization/policysetdefinitions/f5b29bc4-feca-4cc6-a58a-772dd5e290a5"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        parameters             = <<PARAMETERS
        {
          "logAnalytics": {
            "value": "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e/resourcegroups/rg-alz-dev-01/providers/microsoft.operationalinsights/workspaces/logworkspace-corp-alz-dev-01"
          }
        }
          PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Evaluate Private Link Usage" = {
    built_in_assignments = {
      "Evaluate Private Link Usage" = {
        name                   = "Evaluate Private Link Usage"
        description            = "Evaluate Private Link Usage"
        enforce                = true
        policy_definition_id   = "/providers/microsoft.authorization/policysetdefinitions/7379ef4c-89b0-48b6-a5cc-fd3a75eaef93"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS

        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Network interfaces should not have public IPs" = {
    built_in_assignments = {
      "Network interfaces should not have public IPs" = {
        name                   = "Network interfaces should not have public IPs"
        description            = "Network interfaces should not have public IPs"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS

        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Allowed Locations For Resource Deployments" = {
    built_in_assignments = {
      "Allowed Locations For Resource Deployments" = {
        name                   = "Allowed Locations For Resource Deployments"
        description            = "Allowed Locations For Resource Deployments"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        parameters             = <<PARAMETERS
          {
            "listOfAllowedLocations": {
              "value": [
                "eastus2"
              ]
            }
          }
          PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Private Endpoint DNS Configuration" = {
    built_in_assignments = {
      "Private Endpoint DNS Configuration" = {
        name                   = "Private Endpoint DNS Configuration"
        description            = "Private Endpoint DNS Configuration"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Management/managementGroups/8d088ff8-7e52-4d0f-8187-dcd9ca37815a/providers/Microsoft.Authorization/policySetDefinitions/0543ceb01c184419941dd595"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Enable Microsoft Defender for Cloud on your subscription" = {
    built_in_assignments = {
      "Enable Microsoft Defender for Cloud on your subscription" = {
        name                   = "Enable Microsoft Defender for Cloud on your subscription"
        description            = "Enable Microsoft Defender for Cloud on your subscription"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/ac076320-ddcf-4066-b451-6154267e8ad2"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        #parameters             = <<PARAMETERS
        #  PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Microsoft Defender CSPM to be enabled" = {
    built_in_assignments = {
      "Configure Microsoft Defender CSPM to be enabled" = {
        name                   = "Configure Microsoft Defender CSPM to be enabled"
        description            = "Configure Microsoft Defender CSPM to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/689f7782-ef2c-4270-a6d0-7664869076bd"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Microsoft Defender for Storage to be enabled" = {
    built_in_assignments = {
      "Configure Microsoft Defender for Storage to be enabled" = {
        name                   = "Configure Microsoft Defender for Storage to be enabled"
        description            = "Configure Microsoft Defender for Storage to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/cfdc5972-75b3-4418-8ae1-7f5c36839390"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Microsoft Defender for Containers to be enabled" = {
    built_in_assignments = {
      "Configure Microsoft Defender for Containers to be enabled" = {
        name                   = "Configure Microsoft Defender for Containers to be enabled"
        description            = "Configure Microsoft Defender for Containers to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Microsoft Defender for Azure Cosmos DB to be enabled" = {
    built_in_assignments = {
      "Configure Microsoft Defender for Azure Cosmos DB to be enabled" = {
        name                   = "Configure Microsoft Defender for Azure Cosmos DB to be enabled"
        description            = "Configure Microsoft Defender for Azure Cosmos DB to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Azure Defender for Key Vaults to be enabled" = {
    built_in_assignments = {
      "Configure Azure Defender for Key Vaults to be enabled" = {
        name                   = "Configure Azure Defender for Key Vaults to be enabled"
        description            = "Configure Azure Defender for Key Vaults to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Azure Defender for App Service to be enabled" = {
    built_in_assignments = {
      "Configure Azure Defender for App Service to be enabled" = {
        name                   = "Configure Azure Defender for App Service to be enabled"
        description            = "Configure Azure Defender for App Service to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
  "Configure Microsoft Defender for Databases to be enabled" = {
    built_in_assignments = {
      "Configure Microsoft Defender for Databases to be enabled" = {
        name                   = "Configure Microsoft Defender for Databases to be enabled"
        description            = "Configure Microsoft Defender for Databases to be enabled"
        enforce                = true
        policy_definition_id   = "/providers/Microsoft.Authorization/policySetDefinitions/9d46421d-1a48-4636-8d1a-5525ed29172d"
        scope                  = "sub"
        scope_id               = "/subscriptions/9b05b160-4cfc-4441-a0ca-287ccc83659e"
        location               = "eastus2"
        identity_type          = "SystemAssigned"
        role_assignment_needed = false
        # parameters             = <<PARAMETERS
        #   PARAMETERS
        # metadata             = "" # If using metadata - remove brackets and uncomment the <<METADATA -> METADATA Section beneath this and add the appropriate JSON
        # <<METADATA
        # {
        # "category": "General"
        # }
        # METADATA  }
      }
    }
    role_definition_name = ""
  }
}
