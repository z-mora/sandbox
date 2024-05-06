load_balancers = {
  "nlb-lunar-locust-ext-dev" = {
    deletion_protection = false
    internal            = false
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-13001"
        }
      }
      "listener-28089" = {
        port     = 28089
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-13002"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-027a37d849ab8ee4a", "subnet-0284520962c737ae2"]
    target_groups = {
      "tg-nlb-port-13001" = {
        port     = 13001
        protocol = "TCP"
        targets  = ["i-070579fbade65ec33", "i-0bf328dcb5b5a565f"]
        type     = "instance"
        health_check = {
          port     = 13001
          protocol = "TCP"
        }
      }
      "tg-nlb-port-13002" = {
        port     = 13002
        protocol = "TCP"
        targets  = ["i-070579fbade65ec33", "i-0bf328dcb5b5a565f"]
        type     = "instance"
        health_check = {
          port     = 13002
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-00d8bdd6c65158266"
  }
}
