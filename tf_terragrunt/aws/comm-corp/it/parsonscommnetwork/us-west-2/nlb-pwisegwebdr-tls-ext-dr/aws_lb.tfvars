load_balancers = {
  "nlb-pwisegwebdr-tls-ext-dr" = {
    certificates = {
      "pwisegwebdr.parsons.com" = {}
    }
    internal            = false
    deletion_protection = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "TLS"
        default_cert_key = "pwisegwebdr.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-14000"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-0a7371cb720aea008", "subnet-06ea17c42ccdbbf30"]
    target_groups = {
      "tg-nlb-port-14000" = {
        port     = 14000
        protocol = "TCP"
        targets  = ["i-09ab03d27c7cd1a31", "i-0ec491adc72ffdfe3"]
        type     = "instance"
        health_check = {
          port     = 14000
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0c36790973e70111c"
  }
}
