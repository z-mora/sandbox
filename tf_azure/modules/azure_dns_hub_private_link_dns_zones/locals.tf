# The zone names listed below are grouped similarly to Microsoft's documentation at the
# link below to make it easier to review & compare in the future
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns

locals {
  comm_region_codes = ["eus2", "wus2", ]
  comm_region_names = ["eastus2", "westus2", ]
  comm_zone_names = toset(concat(
    # AI + Machine Learning
    [
      "privatelink.api.azureml.ms",
      "privatelink.notebooks.azure.net",
      "privatelink.cognitiveservices.azure.com",
      "privatelink.openai.azure.com",
      "privatelink.directline.botframework.com",
      "privatelink.token.botframework.com",
    ],
    # Analytics
    [
      "privatelink.sql.azuresynapse.net",
      "privatelink.sql.azuresynapse.net",
      "privatelink.dev.azuresynapse.net",
      # The conditional forwarder for azuresynapse.net was causing DNS resolution issues
      # "privatelink.azuresynapse.net",
      "privatelink.servicebus.windows.net",
      "privatelink.servicebus.windows.net",
      "privatelink.datafactory.azure.net",
      "privatelink.adf.azure.com",
      "privatelink.azurehdinsight.net",
    ],
    [for r in local.comm_region_names : "privatelink.${r}.kusto.windows.net"],
    [
      "privatelink.blob.core.windows.net",
      "privatelink.queue.core.windows.net",
      "privatelink.table.core.windows.net",
      # It seems like these would only be used if Power BI is set to use private link
      # for the whole tenant. See STAR-17044
      "privatelink.analysis.windows.net",
      # This conditional forwarder caused DNS resolutions issues & was removed
      # "privatelink.pbidedicated.windows.net",
      "privatelink.tip1.powerquery.microsoft.com",
      "privatelink.azuredatabricks.net",
    ],
    # Compute
    [
      "privatelink.batch.azure.com",
      "service.privatelink.batch.azure.com"
    ],
    # The conditional forwarder for wvd.microsoft.com was causing DNS resolution issues
    # and was removed
    # [
    # "privatelink-global.wvd.microsoft.com",
    # "privatelink.wvd.microsoft.com",
    # "privatelink.wvd.microsoft.com",
    # ],
    # Containers
    [for r in local.comm_region_names : "privatelink.${r}.azmk8s.io"], [
      "privatelink.azurecr.io",
    ],
    # Databases
    [
      "privatelink.database.windows.net",
      "privatelink.documents.azure.com",
      "privatelink.mongo.cosmos.azure.com",
      "privatelink.cassandra.cosmos.azure.com",
      "privatelink.gremlin.cosmos.azure.com",
      "privatelink.table.cosmos.azure.com",
      "privatelink.analytics.cosmos.azure.com",
      "privatelink.postgres.cosmos.azure.com",
      "privatelink.postgres.database.azure.com",
      "privatelink.mysql.database.azure.com",
      "privatelink.mysql.database.azure.com",
      "privatelink.mariadb.database.azure.com",
      "privatelink.redis.cache.windows.net",
      "privatelink.redisenterprise.cache.azure.net",
    ],
    # Hybrid + multicloud
    [
      # The conditional forwarder for his.arc.azure.com was causing DNS resolution issues
      # and was removed. The policy was also removed, which requires all 3 zones.
      # "privatelink.his.arc.azure.com",
      # "privatelink.guestconfiguration.azure.com",
      # "privatelink.dp.kubernetesconfiguration.azure.com",
    ],
    # Integration
    [
      "privatelink.servicebus.windows.net",
      "privatelink.eventgrid.azure.net",
      "privatelink.eventgrid.azure.net",
      "privatelink.eventgrid.azure.net",
      "privatelink.eventgrid.azure.net",
      "privatelink.azure-api.net",
      "privatelink.workspace.azurehealthcareapis.com",
      "privatelink.fhir.azurehealthcareapis.com",
      "privatelink.dicom.azurehealthcareapis.com",
    ],
    # Internet of Things (IoT)
    [
      "privatelink.azure-devices.net",
      "privatelink.servicebus.windows.net",
      "privatelink.azure-devices-provisioning.net",
      "privatelink.api.adu.microsoft.com",
      "privatelink.azureiotcentral.com",
      "privatelink.digitaltwins.azure.net",
    ],
    # Media
    [
      "privatelink.media.azure.net",
    ],
    # Management and Governance
    [
      "privatelink.azure-automation.net",
    ],
    [for r in local.comm_region_codes : "privatelink.${r}.backup.windowsazure.com"],
    [
      "privatelink.siterecovery.windowsazure.com",
      # Private Link for Azure Monitor has to be set up at the tenant level for all networks
      # "privatelink.monitor.azure.com",
      # "privatelink.oms.opinsights.azure.com",
      # "privatelink.ods.opinsights.azure.com",
      # "privatelink.agentsvc.azure-automation.net",
      # "privatelink.blob.core.windows.net",
      "privatelink.purview.azure.com",
      "privatelink.purviewstudio.azure.com",
      "privatelink.prod.migration.windowsazure.com",
      "privatelink.prod.migration.windowsazure.com",
      # I don't think we need private link for Azure Resource Manager...
      # "privatelink.azure.com",
      "privatelink.grafana.azure.com",
    ],
    # Security
    [
      "privatelink.vaultcore.azure.net",
      "privatelink.managedhsm.azure.net",
      "privatelink.azconfig.io",
      "privatelink.attest.azure.net",

    ],
    # Storage
    [
      "privatelink.blob.core.windows.net",
      "privatelink.table.core.windows.net",
      "privatelink.queue.core.windows.net",
      "privatelink.file.core.windows.net",
      "privatelink.web.core.windows.net",
      "privatelink.dfs.core.windows.net",
      "privatelink.afs.azure.net",
      "privatelink.blob.core.windows.net",
    ],
    # Web
    [
      "privatelink.search.windows.net",
      "privatelink.servicebus.windows.net",
      "privatelink.azurewebsites.net",
      # Separate zone isn't needed for scm since it falls within privatelink.azurewebsites.net
      # "scm.privatelink.azurewebsites.net",
      "privatelink.service.signalr.net",
      "privatelink.azurestaticapps.net",
      "privatelink.servicebus.windows.net",
    ],
  ))
  gov_region_codes = ["ugv", ]
  gov_zone_names = toset(concat(
    # AI + Machine Learning
    [
      "privatelink.cognitiveservices.azure.us",
      "privatelink.api.ml.azure.us",
      "privatelink.notebooks.usgovcloudapi.net",
    ],
    # Analytics
    [
      "privatelink.servicebus.usgovcloudapi.net",
      "privatelink.sql.azuresynapse.usgovcloudapi.net",
      "privatelink.sql.azuresynapse.usgovcloudapi.net",
      "privatelink.dev.azuresynapse.usgovcloudapi.net",
      # The conditional forwarder for the public zone in Commerical caused DNS resolution
      # issues, so removing this zone in Gov as well.
      # "privatelink.azuresynapse.usgovcloudapi.net",
      "privatelink.datafactory.azure.us",
      "privatelink.adf.azure.us",
      "privatelink.azurehdinsight.us",
      "privatelink.databricks.azure.us",
    ],
    # Compute
    [
      "privatelink.batch.usgovcloudapi.net",
      "privatelink.batch.usgovcloudapi.net",
      # The conditional forwarder for the public zone in Commerical caused DNS resolution
      # issues, so removing these zones in Gov as well.
      # "privatelink-global.wvd.azure.us",
      # "privatelink.wvd.azure.us",
    ],
    # Containers
    [
      "privatelink.azurecr.us",
    ],
    # Databases
    [
      "privatelink.database.usgovcloudapi.net",
      "privatelink.documents.azure.us",
      "privatelink.mongo.cosmos.azure.us",
      "privatelink.postgres.database.usgovcloudapi.net",
      "privatelink.mysql.database.usgovcloudapi.net",
      "privatelink.mysql.database.usgovcloudapi.net",
      "privatelink.mariadb.database.usgovcloudapi.net",
      "privatelink.redis.cache.usgovcloudapi.net",
    ],
    # Hybrid + multicloud
    [
      # N/A, nothing in documentation yet
    ],
    # Integration
    [
      "privatelink.servicebus.usgovcloudapi.net",
      "privatelink.eventgrid.azure.us",
      "privatelink.eventgrid.azure.us",
      "privatelink.workspace.azurehealthcareapis.us",
      "privatelink.fhir.azurehealthcareapis.us",
      "privatelink.dicom.azurehealthcareapis.us",
    ],
    # Internet of Things (IoT)
    [
      "privatelink.azure-devices.us",
      "privatelink.servicebus.windows.us",
      "privatelink.azure-devices-provisioning.us",
    ],
    # Media
    [
      # N/A, nothing in documentation yet
    ],
    # Management and Governance
    [
      "privatelink.azure-automation.us",
    ],
    [for r in local.gov_region_codes : "privatelink.${r}.backup.windowsazure.us"],
    [
      "privatelink.siterecovery.windowsazure.us",
      # Private Link for Azure Monitor has to be set up at the tenant level for all networks
      # "privatelink.monitor.azure.us",
      # "privatelink.adx.monitor.azure.us",
      # "privatelink.oms.opinsights.azure.us",
      # "privatelink.ods.opinsights.azure.us",
      # "privatelink.agentsvc.azure-automation.us",
      # "privatelink.blob.core.usgovcloudapi.net",
      "privatelink.purview.azure.us",
      "privatelink.purviewstudio.azure.us",
    ],
    # Security
    [
      "privatelink.vaultcore.usgovcloudapi.net",
      "privatelink.azconfig.azure.us",
    ],
    # Storage
    [
      "privatelink.blob.core.usgovcloudapi.net",
      "privatelink.table.core.usgovcloudapi.net",
      "privatelink.queue.core.usgovcloudapi.net",
      "privatelink.file.core.usgovcloudapi.net",
      "privatelink.web.core.usgovcloudapi.net",
      "privatelink.dfs.core.usgovcloudapi.net",
    ],
    # Web
    [
      "privatelink.search.windows.us",
      "privatelink.servicebus.usgovcloudapi.net",
      "privatelink.azurewebsites.us",
      # Separate zone isn't needed for scm since it falls within privatelink.azurewebsites.us
      # "scm.privatelink.azurewebsites.us",
      "privatelink.servicebus.usgovcloudapi.net",
    ],
  ))
  zones_and_vnets = merge([for zone in local.zone_names : {
    for k, v in var.vnet_ids : "${zone}-${k}" => { zone_name = zone, vnet_key = k }
  }]...)
  zone_names = var.is_gov ? local.gov_zone_names : local.comm_zone_names
}
