load_balancers = {
  "nlb-adactimesheet-tls-ext-prod" = {
    deletion_protection = true
    certificates = {
      "adactimesheet.parsons.com" = {}
    }
    internal = false
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "TLS"
        default_cert_key = "adactimesheet.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-12004"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-077e56a52cf810ee1", "subnet-07266b8c4a4d17051"]
    target_groups = {
      "tg-nlb-port-12004" = {
        port     = 12004
        protocol = "TCP"
        targets  = ["i-0ffbdcf0156a0e976", "i-04d057ce9f9b4b6fa"]
        type     = "instance"
        health_check = {
          port     = 12004
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0caf31a1f2e35ac89"
  }
}
