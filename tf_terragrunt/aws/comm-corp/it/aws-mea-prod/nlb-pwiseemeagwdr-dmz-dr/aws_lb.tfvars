load_balancers = {
  "nlb-pwiseemeagwdr-dmz-dr" = {
    deletion_protection = true
    internal            = true
    listeners = {
      "listener-5800" = {
        port     = 5800
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-5800"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-0372bda1b16b6ac07", "subnet-0bc7bb83d37b46d4b"]
    target_groups = {
      "tg-nlb-port-5800" = {
        port     = 5800
        protocol = "TCP"
        targets  = ["10.224.4.12"]
        type     = "ip"
        health_check = {
          port     = 5800
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0d4892a536d91f305"
  }
}
