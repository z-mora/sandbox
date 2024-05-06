load_balancers = {
  "nlb-adactimesheet-int-prod" = {
    certificates = {
      "adactimesheet.parsons.com" = {}
    }
    deletion_protection     = true
    external_tls_decryption = false
    internal                = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "TLS"
        default_cert_key = "adactimesheet.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = false
    subnet_ids         = ["subnet-0372bda1b16b6ac07", "subnet-0bc7bb83d37b46d4b"]
    target_groups = {
      "tg-port-443" = {
        port                    = 443
        protocol                = "TLS"
        targets                 = ["10.224.4.45"]
        type                    = "ip"
        nlb_targets_outside_vpc = false
        health_check = {
          port     = 443
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0d4892a536d91f305"
  }
}
