load_balancers = {
  "nlb-clmmatrix-int-prod" = {
    internal = true
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-026b077c5a07c181d", "subnet-00e471ab24d84303e"]
    target_groups = {
      "tg-port-443" = {
        port                    = 443
        protocol                = "TCP"
        targets                 = ["10.33.3.67", "10.33.2.32"]
        type                    = "ip"
        nlb_targets_outside_vpc = false
        health_check = {
          port     = 443
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-06bb028b8fcb50483"
  }
}
