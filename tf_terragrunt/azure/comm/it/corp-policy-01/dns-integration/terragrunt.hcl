include "root" {
  path = find_in_parent_folders("azure.hcl")
}

dependencies {
  paths = [
    "${get_repo_root()}/azure/comm/it/management-groups",
    "../dns-integration-custom"
  ]
}

locals {
  dns_hub_subscription = "/subscriptions/e45d6712-fcba-4a53-bcef-9f8817d2632a"
  zone_id_base         = "${local.dns_hub_subscription}/resourceGroups/rg-dns-prod-01/providers/Microsoft.Network/privateDnsZones"
}

inputs = {
  policy_initiatives = {
    parsons-private-endpoint-dns-configuration = {
      assignments = {
        sub-comm-corp-infraops-dev-01 = {
          identity = {
            managed_identity_keys = ["id-private-endpoint-dns-configuration"]
            type                  = "UserAssigned"
          }
          scope_type = "subscription"
        }
      }
      description                   = <<-DESCRIPTION
      This policy initiative is a work in progress. It will configure private endpoints'
      DNS integration to create DNS records in the private link DNS zones in the
      corporate DNS subscription.

      NOTE: The policy references are organized according to the documentation "Azure
      Private Endpoint private DNS zone values" found here:
      https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns

      If you make changes, please keep them in line with this doc (category, order, etc.)
      DESCRIPTION
      display_name                  = "Parsons - WIP - Private endpoint DNS Configuration"
      management_group_display_name = "Tenant Root Group"
      metadata                      = { category = "Network" }
      policy_definition_groups = {
        "AI + Machine Learning"     = { category = "AI + Machine Learning" }
        Analytics                   = { category = "Analytics" }
        Compute                     = { category = "Compute" }
        Containers                  = { category = "Containers" }
        Databases                   = { category = "Databases" }
        "Hybrid + multicloud"       = { category = "Hybrid + multicloud" }
        Integration                 = { category = "Integration" }
        "Internet of Things (IoT)"  = { category = "Internet of Things (IoT)" }
        "Management and Governance" = { category = "Management and Governance" }
        Media                       = { category = "Media" }
        Security                    = { category = "Security" }
        Storage                     = { category = "Storage" }
        Web                         = { category = "Web" }
      }
      policy_definition_references = {
        "Configure Azure Machine Learning workspace to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.api.azureml.ms"
            }
            secondPrivateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.notebooks.azure.net"
            }
          }
          policy_group_names = ["AI + Machine Learning"]
        }
        "Parsons-Configure Azure Cognitive Services - accounts - to use private DNS zones" = {
          parameters = {
            defaultPrivateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.cognitiveservices.azure.com"
            }
            openaiPrivateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.openai.azure.com"
            }
          }
          policy_group_names = ["AI + Machine Learning"]
        }
        "Configure BotService resources to use private DNS zones - Bot" = {
          definition_display_name = "Configure BotService resources to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.directline.botframework.com"
            }
            privateEndpointGroupId = {
              string_value = "Bot"
            }
          }
          policy_group_names = ["AI + Machine Learning"]
        }
        "Configure BotService resources to use private DNS zones - Token" = {
          definition_display_name = "Configure BotService resources to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.token.botframework.com"
            }
            privateEndpointGroupId = {
              string_value = "Token"
            }
          }
          policy_group_names = ["AI + Machine Learning"]
        }
        "Configure Azure Synapse workspaces to use private DNS zones - Sql" = {
          definition_display_name = "Configure Azure Synapse workspaces to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.sql.azuresynapse.net"
            }
            targetSubResource = {
              string_value = "Sql"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Azure Synapse workspaces to use private DNS zones - SqlOnDemand" = {
          definition_display_name = "Configure Azure Synapse workspaces to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.sql.azuresynapse.net"
            }
            targetSubResource = {
              string_value = "SqlOnDemand"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Azure Synapse workspaces to use private DNS zones - Dev" = {
          definition_display_name = "Configure Azure Synapse workspaces to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.dev.azuresynapse.net"
            }
            targetSubResource = {
              string_value = "Dev"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Event Hub namespaces to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.servicebus.windows.net"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Service Bus namespaces to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.servicebus.windows.net"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure private DNS zones for private endpoints that connect to Azure Data Factory - dataFactory" = {
          definition_display_name = "Configure private DNS zones for private endpoints that connect to Azure Data Factory"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.datafactory.azure.net"
            }
            listOfGroupIds = {
              list_value = ["dataFactory"]
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure private DNS zones for private endpoints that connect to Azure Data Factory - portal" = {
          definition_display_name = "Configure private DNS zones for private endpoints that connect to Azure Data Factory"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.adf.azure.com"
            }
            listOfGroupIds = {
              list_value = ["portal"]
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Parsons-Configure Azure hdinsight - clusters - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azurehdinsight.net"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Parsons-Configure Azure Kusto - cluster - East US 2 - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.eastus2.kusto.windows.net"
            }
            privateDnsZoneId-Blob = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
            privateDnsZoneId-Queue = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
            privateDnsZoneId-Table = {
              string_value = "${local.zone_id_base}/privatelink.table.core.windows.net"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Parsons-Configure Azure Kusto - cluster - West US 2 - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.westus2.kusto.windows.net"
            }
            privateDnsZoneId-Blob = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
            privateDnsZoneId-Queue = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
            privateDnsZoneId-Table = {
              string_value = "${local.zone_id_base}/privatelink.table.core.windows.net"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Azure Databricks workspace to use private DNS zones - databricks_ui_api" = {
          definition_display_name = "Configure Azure Databricks workspace to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azuredatabricks.net"
            }
            groupId = {
              string_value = "databricks_ui_api"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Configure Azure Databricks workspace to use private DNS zones - browser_authentication" = {
          definition_display_name = "Configure Azure Databricks workspace to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azuredatabricks.net"
            }
            groupId = {
              string_value = "browser_authentication"
            }
          }
          policy_group_names = ["Analytics"]
        }
        "Parsons-Configure Azure Batch - batchAccount - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.batch.azure.com"
            }
          }
          policy_group_names = ["Compute"]
        }
        "Parsons-Configure Azure Batch - nodeManagement - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/service.privatelink.batch.azure.com"
            }
          }
          policy_group_names = ["Compute"]
        }
        # Removing these policies, as the conditional forwarder for wvd.microsoft.com
        # was removed after causing DNS resolution issues. The private DNS zones for this
        # service have also been removed.
        # "Configure Azure Virtual Desktop workspace resources to use private DNS zones" = {
        #   parameters = {
        #     privateDnsZoneId = {
        #       string_value = "${local.zone_id_base}/privatelink.wvd.microsoft.com"
        #     }
        #     privateEndpointGroupId = {
        #       string_value = "feed"
        #     }
        #   }
        #   policy_group_names = ["Compute"]
        # }
        # "Configure Azure Virtual Desktop hostpool resources to use private DNS zones" = {
        #   parameters = {
        #     privateDnsZoneId = {
        #       string_value = "${local.zone_id_base}/privatelink.wvd.microsoft.com"
        #     }
        #     privateEndpointGroupId = {
        #       string_value = "connection"
        #     }
        #   }
        #   policy_group_names = ["Compute"]
        # }
        "Parsons-Configure Azure Kubernetes Service - API - Managed Clusters - East US 2 -to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.eastus2.azmk8s.io"
            }
          }
          policy_group_names = ["Containers"]
        }
        "Parsons-Configure Azure Kubernetes Service - API - Managed Clusters - West US 2 -to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.westus2.azmk8s.io"
            }
          }
          policy_group_names = ["Containers"]
        }
        "Parsons-Configure Azure Container Registry - registry - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azurecr.io"
            }
          }
          policy_group_names = ["Containers"]
        }
        "Parsons-Configure Azure SQL DB - server - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.database.windows.net"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - Sql" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.documents.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "Sql"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - MongoDB" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.mongo.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "MongoDB"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - Cassandra" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.cassandra.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "Cassandra"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - Gremlin" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.gremlin.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "Gremlin"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - Table" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.table.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "Table"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - Analytical" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.analytics.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "Analytical"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure CosmosDB accounts to use private DNS zones - coordinator" = {
          definition_display_name = "Configure CosmosDB accounts to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.postgres.cosmos.azure.com"
            }
            privateEndpointGroupId = {
              string_value = "coordinator"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Configure Azure Cache for Redis to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.redis.cache.windows.net"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Parsons-Configure Azure MySQL DB - flexible - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.mysql.database.azure.com"
            }
          }
          policy_group_names = ["Databases"]
        }
        "Parsons-Configure Azure Cache - RedisEnterprise - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.redisenterprise.cache.azure.net"
            }
          }
          policy_group_names = ["Databases"]
        }
        # Removing this policy, as the conditional forwarder for his.arc.azure.com
        # was removed after causing DNS resolution issues. The private DNS zones for this
        # service have also been removed.
        # "Configure Azure Arc Private Link Scopes to use private DNS zones" = {
        #   parameters = {
        #     privateDnsZoneIDForGuestConfiguration = {
        #       string_value = "${local.zone_id_base}/privatelink.guestconfiguration.azure.com"
        #     }
        #     privateDnsZoneIDForHybridResourceProvider = {
        #       string_value = "${local.zone_id_base}/privatelink.his.arc.azure.com"
        #     }
        #     privateDnsZoneIDForKubernetesConfiguration = {
        #       string_value = "${local.zone_id_base}/privatelink.dp.kubernetesconfiguration.azure.com"
        #     }
        #   }
        #   policy_group_names = ["Hybrid + multicloud"]
        # }
        "Deploy - Configure Azure Event Grid topics to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.eventgrid.azure.net"
            }
          }
          policy_group_names = ["Integration"]
        }
        "Deploy - Configure Azure Event Grid domains to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.eventgrid.azure.net"
            }
          }
          policy_group_names = ["Integration"]
        }
        "Parsons-Configure Azure Event Grid - partnerNamespaces - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.eventgrid.azure.net"
            }
          }
          policy_group_names = ["Integration"]
        }
        "Parsons-Configure Azure Api Management - gateway - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azure-api.net"
            }
          }
          policy_group_names = ["Integration"]
        }
        "Parsons-Configure  Healthcare API - workspaces - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId-workspace = {
              string_value = "${local.zone_id_base}/privatelink.workspace.azurehealthcareapis.com"
            }
            privateDnsZoneId-fhir = {
              string_value = "${local.zone_id_base}/privatelink.fhir.azurehealthcareapis.com"
            }
            privateDnsZoneId-dicom = {
              string_value = "${local.zone_id_base}/privatelink.dicom.azurehealthcareapis.com"
            }
          }
          policy_group_names = ["Integration"]
        }
        "Parsons-Configure Azure IoT Hubs to use private DNS zones" = {
          parameters = {
            privateDnsZoneId_azure-devices-net = {
              string_value = "${local.zone_id_base}/privatelink.azure-devices.net"
            }
            privateDnsZoneId_servicebus-windows-net = {
              string_value = "${local.zone_id_base}/privatelink.servicebus.windows.net"
            }
          }
          policy_group_names = ["Internet of Things (IoT)"]
        }
        "Configure IoT Hub device provisioning instances to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azure-devices-provisioning.net"
            }
          }
          policy_group_names = ["Internet of Things (IoT)"]
        }
        "Configure Azure Device Update for IoT Hub accounts to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.api.adu.microsoft.com"
            }
          }
          policy_group_names = ["Internet of Things (IoT)"]
        }
        "Deploy - Configure IoT Central to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azureiotcentral.com"
            }
          }
          policy_group_names = ["Internet of Things (IoT)"]
        }
        "Parsons-Configure  Digital Twins - API - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.digitaltwins.azure.net"
            }
          }
          policy_group_names = ["Internet of Things (IoT)"]
        }
        "Configure Azure Media Services to use private DNS zones - keydelivery" = {
          definition_display_name = "Configure Azure Media Services to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.media.azure.net"
            }
            groupId = {
              string_value = "keydelivery"
            }
          }
          policy_group_names = ["Media"]
        }
        "Configure Azure Media Services to use private DNS zones - liveevent" = {
          definition_display_name = "Configure Azure Media Services to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.media.azure.net"
            }
            groupId = {
              string_value = "liveevent"
            }
          }
          policy_group_names = ["Media"]
        }
        "Configure Azure Media Services to use private DNS zones - streamingendpoint" = {
          definition_display_name = "Configure Azure Media Services to use private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.media.azure.net"
            }
            groupId = {
              string_value = "streamingendpoint"
            }
          }
          policy_group_names = ["Media"]
        }
        "Configure Azure Automation accounts with private DNS zones - Webhook" = {
          definition_display_name = "Configure Azure Automation accounts with private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azure-automation.net"
            }
            privateEndpointGroupId = {
              string_value = "Webhook"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Parsons-Configure East US 2 - MS Azure Backup - Recovery Services Vaults - Azure Backup - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId-Backup = {
              string_value = "${local.zone_id_base}/privatelink.eus2.backup.windowsazure.com"
            }
            privateDnsZoneId-Blob = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
            privateDnsZoneId-Queue = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Parsons-Configure West US 2 - MS Azure Backup - Recovery Services Vaults - Azure Backup - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId-Backup = {
              string_value = "${local.zone_id_base}/privatelink.wus2.backup.windowsazure.com"
            }
            privateDnsZoneId-Blob = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
            privateDnsZoneId-Queue = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Configure Azure Automation accounts with private DNS zones - DSCAndHybridWorker" = {
          definition_display_name = "Configure Azure Automation accounts with private DNS zones"
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azure-automation.net"
            }
            privateEndpointGroupId = {
              string_value = "DSCAndHybridWorker"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "[Preview]: Configure Azure Recovery Services vaults to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.siterecovery.windowsazure.com"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Parsons-Configure MS Purview Accounts - account - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.purview.azure.com"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Parsons-Configure MS Purview Accounts - portal - to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.purviewstudio.azure.com"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Configure Azure Migrate resources to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.prod.migration.windowsazure.com"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Configure Azure Managed Grafana workspaces to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.grafana.azure.com"
            }
          }
          policy_group_names = ["Management and Governance"]
        }
        "Configure Azure Key Vaults to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.vaultcore.azure.net"
            }
          }
          policy_group_names = ["Security"]
        }
        "Parsons-Configure Azure Key Vault managedHSMs to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.managedhsm.azure.net"
            }
          }
          policy_group_names = ["Security"]
        }
        "Configure private DNS zones for private endpoints connected to App Configuration" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azconfig.io"
            }
          }
          policy_group_names = ["Security"]
        }
        "Parsons-Configure Azure Attestation to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.attest.azure.net"
            }
          }
          policy_group_names = ["Security"]
        }
        "Configure a private DNS Zone ID for blob groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for blob_secondary groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for table groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.table.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for table_secondary groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.table.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for queue groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for queue_secondary groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.queue.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for file groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.file.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for web groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.web.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for web_secondary groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.web.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for dfs groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.dfs.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure a private DNS Zone ID for dfs_secondary groupID" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.dfs.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure Azure File Sync to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.afs.azure.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure disk access resources to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.blob.core.windows.net"
            }
          }
          policy_group_names = ["Storage"]
        }
        "Configure Azure Cognitive Search services to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.search.windows.net"
            }
          }
          policy_group_names = ["Web"]
        }
        "Configure App Service apps to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azurewebsites.net"
            }
          }
          policy_group_names = ["Web"]
        }
        "Deploy - Configure private DNS zones for private endpoints connect to Azure SignalR Service" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.service.signalr.net"
            }
          }
          policy_group_names = ["Web"]
        }
        "Parsons-Configure Static Web Apps apps to use private DNS zones" = {
          parameters = {
            privateDnsZoneId = {
              string_value = "${local.zone_id_base}/privatelink.azurestaticapps.net"
            }
          }
          policy_group_names = ["Web"]
        }
      }
    }
  }
}
