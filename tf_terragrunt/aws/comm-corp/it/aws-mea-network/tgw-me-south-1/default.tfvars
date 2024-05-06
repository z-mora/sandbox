default_tags = {
  App         = "N/A"
  Environment = "PROD"
  GBU         = "COR"
  ITSM        = "NETWORK"
  JobWbs      = "897720-01102"
  Owner       = "infraopscloud@parsons.com"
}
# Override network_account_id - MEA is in the same Comm Corp org, but has its own
# network account which the tgw_route_table module uses
network_account_id = "823189731912"
region             = "me-south-1"
