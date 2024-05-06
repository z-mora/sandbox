load_balancers = {
  "nlb-smoke-ext-dev" = {
    deletion_protection = false
    internal            = false
    listeners = {
      "listener-22" = {
        port     = 22
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-13003"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-027a37d849ab8ee4a", "subnet-0284520962c737ae2"]
    target_groups = {
      "tg-nlb-port-13003" = {
        port     = 13003
        protocol = "TCP"
        targets  = ["i-070579fbade65ec33", "i-0bf328dcb5b5a565f"]
        type     = "instance"
        health_check = {
          port     = 13003
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-00d8bdd6c65158266"
  }
}
