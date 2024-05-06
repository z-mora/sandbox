load_balancers = {
  "nlb-altium-ext-prod" = {
    deletion_protection = false
    internal            = false
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-10047"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-04cc474aad3db5853", "subnet-0cfed5232ef696395"]
    target_groups = {
      "tg-nlb-port-10047" = {
        port     = 10047
        protocol = "TCP"
        targets  = ["i-0576edd3848d019c3", "i-07b7c438954dd4436"]
        type     = "instance"
        health_check = {
          port     = 10047
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-017209364ef1510c2"
  }
}
