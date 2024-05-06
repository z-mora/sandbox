load_balancers = {
  "nlb-bots-tls-ext-prod" = {
    certificates = {
      "bots.parsons.com"           = {}
      "givesback.bots.parsons.com" = {}
    }
    internal = false
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "TLS"
        default_cert_key    = "bots.parsons.com"
        secondary_cert_keys = ["givesback.bots.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11037"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-06bcb8d36f20ba24e", "subnet-04030635e8ee35895"]
    target_groups = {
      "tg-nlb-port-11037" = {
        port     = 11037
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11037
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0f33b8af8702635e7"
  }
}
