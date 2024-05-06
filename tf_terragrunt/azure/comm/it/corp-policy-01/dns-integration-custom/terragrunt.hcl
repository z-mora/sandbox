include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependencies {
  paths = ["${get_repo_root()}/azure/comm/it/management-groups"]
}

inputs = {
  custom_policy_definitions = {
    "parsons-configure-staticsites-privatednszones" = {
      description  = "Configure the private dns integration for a Static Web Apps private endpoint."
      display_name = "Parsons-Configure Static Web Apps apps to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-staticsites-privatednszones.json")
    }
    "parsons-configure-azureiothubs-privatednszones" = {
      description  = "Configure the private dns integration for Azure IoT Hub private endpoints."
      display_name = "Parsons-Configure Azure IoT Hubs to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId_azure-devices-net" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in the azure-devices.net private DNS zone group and link to the private endpoint"
            displayName = "azure-devices.net-Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId_servicebus-windows-net" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in the  private DNS zone group and link to the private endpoint"
            displayName = "servicebus.windows.net-Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-azureiothubs-privatednszones.json")
    }
    "parsons-configure-azureattestation-privatednszones" = {
      description  = "Configure the private dns integration for Azure Attestation private endpoints."
      display_name = "Parsons-Configure Azure Attestation to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-azureattestation-privatednszones.json")
    }
    "parsons-configure-managedHSMs-privatednszones" = {
      description  = "Configure the private dns integration for Azure Key Vault managedHSMs private endpoints."
      display_name = "Parsons-Configure Azure Key Vault managedHSMs to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-managedHSMs-privatednszones.json")
    }
    "parsons-configure-purviewaccounts-portal-privatednszones" = {
      description  = "Configure the private dns integration for MS Purview Accounts - portal - private endpoints."
      display_name = "Parsons-Configure MS Purview Accounts - portal - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-purviewaccounts-portal-privatednszones.json")
    }
    "parsons-configure-purviewaccounts-account-privatednszones" = {
      description  = "Configure the private dns integration for MS Purview Accounts - account - private endpoints."
      display_name = "Parsons-Configure MS Purview Accounts - account - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-purviewaccounts-account-privatednszones.json")
    }
    "parsons-configure-azurebackup-eastus2-privatednszones" = {
      description  = "Configure the private dns integration for MS Azure Backup - Recovery Services Vaults - Azure Backup - private endpoints in East US 2 region."
      display_name = "Parsons-Configure East US 2 - MS Azure Backup - Recovery Services Vaults - Azure Backup - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId-Backup" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Backup service."
            displayName       = "Private Dns Zone Id - Backup"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "privateDnsZoneId-Blob" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Blob service."
            displayName       = "Private Dns Zone Id - Blob"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "privateDnsZoneId-Queue" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Queue service."
            displayName       = "Private Dns Zone Id - Queue"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-azurebackup-eastus2-privatednszones.json")
    }
    "parsons-configure-azurebackup-westus2-privatednszones" = {
      description  = "Configure the private dns integration for MS Azure Backup - Recovery Services Vaults - Azure Backup - private endpoints in West US 2 region."
      display_name = "Parsons-Configure West US 2 - MS Azure Backup - Recovery Services Vaults - Azure Backup - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId-Backup" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Backup service."
            displayName       = "Private Dns Zone Id - Backup"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "privateDnsZoneId-Blob" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Blob service."
            displayName       = "Private Dns Zone Id - Blob"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "privateDnsZoneId-Queue" = {
          type = "String"
          metadata = {
            description       = "Specifies private DNS Zone ID required to resolve DNS to private IP for the Azure Queue service."
            displayName       = "Private Dns Zone Id - Queue"
            strongType        = "Microsoft.Network/privateDnsZones"
            assignPermissions = true
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-azurebackup-westus2-privatednszones.json")
    }
    "parsons-configure-digitaltwins-api-privatednszones" = {
      description  = "Configure the private dns integration for Digital Twins - API - private endpoints."
      display_name = "Parsons-Configure  Digital Twins - API - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-digitaltwins-api-privatednszones.json")
    }
    "parsons-configure-healthcareapi-workspaces-privatednszones" = {
      description  = "Configure the private dns integration for Healthcare API - workspaces - private endpoints."
      display_name = "Parsons-Configure  Healthcare API - workspaces - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId-workspace" = {
          type = "String"
          metadata = {
            description = "The private DNS zone for workspace to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id-workspace"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-fhir" = {
          type = "String"
          metadata = {
            description = "The private DNS zone for fhir to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id-fhir"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-dicom" = {
          type = "String"
          metadata = {
            description = "The private DNS zone for dicom to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id-dicom"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-healthcareapi-workspaces-privatednszones.json")
    }
    "parsons-configure-cache-redisEnterprise-privatednszones" = {
      description  = "Configure the private dns integration for Azure Cache - RedisEnterprise - private endpoints."
      display_name = "Parsons-Configure Azure Cache - RedisEnterprise - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-cache-redisEnterprise-privatednszones.json")
    }
    "parsons-configure-eventgrid-partnernamespaces-privatednszones" = {
      description  = "Configure the private dns integration for Azure Event Grid - partnerNamespaces - private endpoints."
      display_name = "Parsons-Configure Azure Event Grid - partnerNamespaces - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-eventgrid-partnernamespaces-privatednszones.json")
    }
    "parsons-configure-apimanagement-gateway-privatednszones" = {
      description  = "Configure the private dns integration for Azure Api Management - gateway - private endpoints."
      display_name = "Parsons-Configure Azure Api Management - gateway - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-apimanagement-gateway-privatednszones.json")
    }
    "parsons-configure-MySQLDB-flexible-privatednszones" = {
      description  = "Configure the private dns integration for Azure MySQL DB - flexible - private endpoints."
      display_name = "Parsons-Configure Azure MySQL DB - flexible - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-MySQLDB-flexible-privatednszones.json")
    }
    "parsons-configure-SQLDB-server-privatednszones" = {
      description  = "Configure the private dns integration for Azure SQL DB - server - private endpoints."
      display_name = "Parsons-Configure Azure SQL DB - server - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-SQLDB-server-privatednszones.json")
    }
    "parsons-configure-containerregistry-privatednszones" = {
      description  = "Configure the private dns integration for Azure Container Registry - registry - private endpoints."
      display_name = "Parsons-Configure Azure Container Registry - registry - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-containerregistry-privatednszones.json")
    }
    "parsons-configure-kubernetes-eastus2-privatednszones" = {
      description  = "Configure the private dns integration for Azure Kubernetes Service - API - Managed Clusters - East US 2 - private endpoints."
      display_name = "Parsons-Configure Azure Kubernetes Service - API - Managed Clusters - East US 2 -to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-kubernetes-eastus2-privatednszones.json")
    }
    "parsons-configure-kubernetes-westus2-privatednszones" = {
      description  = "Configure the private dns integration for Azure Kubernetes Service - API - Managed Clusters - West US 2 - private endpoints."
      display_name = "Parsons-Configure Azure Kubernetes Service - API - Managed Clusters - West US 2 -to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-kubernetes-westus2-privatednszones.json")
    }
    "parsons-configure-batch-nodeManagement-privatednszones" = {
      description  = "Configure the private dns integration for Azure Batch - nodeManagement - private endpoints."
      display_name = "Parsons-Configure Azure Batch - nodeManagement - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-batch-nodeManagement-privatednszones.json")
    }
    "parsons-configure-batch-batchAccount-privatednszones" = {
      description  = "Configure the private dns integration for Azure Batch - batchAccount - private endpoints."
      display_name = "Parsons-Configure Azure Batch - batchAccount - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-batch-batchAccount-privatednszones.json")
    }
    "parsons-configure-Kusto-clusters-eastus2-privatednszones" = {
      description  = "Configure the private dns integration for Azure Kusto - cluster - eastus2 - private endpoints."
      display_name = "Parsons-Configure Azure Kusto - cluster - East US 2 - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Blob" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Queue" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Table" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-Kusto-cluster-eastus2-privatednszones.json")
    }
    "parsons-configure-Kusto-cluster-westus2-privatednszones" = {
      description  = "Configure the private dns integration for Azure Kusto - cluster - West US 2 - private endpoints."
      display_name = "Parsons-Configure Azure Kusto - cluster - West US 2 - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Blob" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Queue" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "privateDnsZoneId-Table" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-Kusto-cluster-westus2-privatednszones.json")
    }
    "parsons-configure-cognitiveservices-accounts-privatednszones" = {
      description  = "Configure the private dns integration for Azure Cognitive Services - accounts - private endpoints."
      display_name = "Parsons-Configure Azure Cognitive Services - accounts - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "defaultPrivateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "openaiPrivateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The Private DNS Zone ID for Azure OpenAI resources."
            displayName = "OpenAI Private DNS Zone ID"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-cognitiveservices-accounts-privatednszones.json")
    }
    "parsons-configure-hdinsight-clusters-privatednszones" = {
      description  = "Configure the private dns integration for Azure hdinsight - clusters - private endpoints."
      display_name = "Parsons-Configure Azure hdinsight - clusters - to use private DNS zones"
      mode         = "Indexed"
      parameters = {
        "privateDnsZoneId" = {
          type = "String"
          metadata = {
            description = "The private DNS zone to deploy in a private DNS zone group and link to the private endpoint"
            displayName = "Private Dns Zone Id"
            strongType  = "Microsoft.Network/privateDnsZones"
          }
        }
        "effect" = {
          type = "String"
          metadata = {
            description = "Enable or disable the execution of the policy"
            displayName = "Effect"
          }
          allowedValues = [
            "DeployIfNotExists",
            "Disabled"
          ]
          defaultValue = "DeployIfNotExists"
        }
      }
      policy_rule = file("parsons-configure-hdinsight-clusters-privatednszones.json")
    }
  }
}
