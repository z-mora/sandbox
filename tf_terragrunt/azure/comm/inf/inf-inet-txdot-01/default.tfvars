default_tags = {
  App         = "iNET TxDOT Austin"
  Environment = "DEV"
  GBU         = "INF"
  ITSM        = "MANAGEMENT"
  JobWbs      = "684743-01300"
  Owner       = "emily.silverman@parsons.com"
}
deploy_network_watcher = true
management_group_name  = "mg-inet-01"
resource_groups        = { "rg-inet-txdot-dev-01" = "eastus2" }
subscription_id        = "1f4c8697-9d13-442a-ab39-e55f0f963067" # sub-comm-inf-inet-txdot-01
