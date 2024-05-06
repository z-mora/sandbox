load_balancers = {
  "nlb-pwiseemeagwdr-ext-dr" = {
    deletion_protection = true
    internal            = false
    listeners = {
      "listener-5800" = {
        port     = 5800
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-12003"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-077e56a52cf810ee1", "subnet-07266b8c4a4d17051"]
    target_groups = {
      "tg-nlb-port-12003" = {
        port     = 12003
        protocol = "TCP"
        targets  = ["i-0ffbdcf0156a0e976", "i-04d057ce9f9b4b6fa"]
        type     = "instance"
        health_check = {
          port     = 12003
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0caf31a1f2e35ac89"
  }
}
