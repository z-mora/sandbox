default_tags = {
  App         = "iNET-SH130"
  Environment = "PROD"
  GBU         = "INF"
  ITSM        = "MANAGEMENT"
  JobWbs      = "684350-09900"
  Owner       = "adam.chandler@parsons.com"
}
deploy_network_watcher = true
management_group_name  = "mg-inet-01"
resource_groups        = { "rg-inet-sh130-prod-01" = "eastus2" }
subscription_id        = "15e686e7-49f2-468c-a285-b679b8f88add" # sub-comm-inf-inet-sh130-01
