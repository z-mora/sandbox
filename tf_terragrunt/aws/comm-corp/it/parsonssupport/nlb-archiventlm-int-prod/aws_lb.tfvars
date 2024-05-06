load_balancers = {
  "nlb-archiventlm-int-prod" = {
    deletion_protection     = true
    external_tls_decryption = false
    internal                = true
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
    subnet_ids             = ["subnet-9483babc", "subnet-ab23dcdc"]
    target_groups = {
      "tg-port-443" = {
        port     = 443
        protocol = "TCP"
        targets  = ["10.45.2.66", "10.45.1.244"]
        type     = "ip"
        health_check = {
          port     = 443
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-59e9373c"
  }
}
