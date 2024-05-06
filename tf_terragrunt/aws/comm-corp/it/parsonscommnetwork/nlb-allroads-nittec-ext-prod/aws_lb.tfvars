load_balancers = {
  "nlb-allroads-nittec-ext-prod" = {
    internal = false
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11064"
        }
      }
      "listener-8443" = {
        port     = 8443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11065"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-06bcb8d36f20ba24e", "subnet-04030635e8ee35895"]
    target_groups = {
      "tg-nlb-port-11064" = {
        port     = 11064
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11064
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
      "tg-nlb-port-11065" = {
        port     = 11065
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11065
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0f33b8af8702635e7"
  }
}
