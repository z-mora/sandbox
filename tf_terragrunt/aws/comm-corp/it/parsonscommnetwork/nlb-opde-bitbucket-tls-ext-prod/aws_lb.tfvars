load_balancers = {
  "nlb-opde-bitbucket-tls-ext-prod" = {
    certificates = {
      "bitbucket.parsons.com" = {}
      "git.parsons.com"       = {}
    }
    internal = false
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "TLS"
        default_cert_key    = "bitbucket.parsons.com"
        secondary_cert_keys = ["git.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11092"
        }
      }
      "listener-7999" = {
        port     = 7999
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11093"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-06bcb8d36f20ba24e", "subnet-04030635e8ee35895"]
    target_groups = {
      "tg-nlb-port-11092" = {
        port     = 11092
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11092
          protocol = "TCP"
        }
      }
      "tg-nlb-port-11093" = { #ssh listener
        port     = 11093
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11093
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0f33b8af8702635e7"
  }
}
