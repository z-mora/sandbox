load_balancers = {
  "nlb-adactimesheet-dmz-prod" = {
    deletion_protection     = true
    external_tls_decryption = true
    internal                = true
    listeners = {
      "listener-80" = {
        port     = 80
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-80"
        }
      }
    }
    redirect_80_to_443 = false
    subnet_ids         = ["subnet-0372bda1b16b6ac07", "subnet-0bc7bb83d37b46d4b"]
    target_groups = {
      "tg-port-80" = {
        port                    = 80
        protocol                = "TCP"
        targets                 = ["10.224.4.45"]
        type                    = "ip"
        nlb_targets_outside_vpc = false
        health_check = {
          port     = 80
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0d4892a536d91f305"
  }
}
