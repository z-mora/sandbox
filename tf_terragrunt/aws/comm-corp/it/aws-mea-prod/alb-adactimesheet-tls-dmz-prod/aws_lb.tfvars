load_balancers = {
  "alb-adactimesheet-tls-dmz-prod" = {
    alb_drop_invalid_header_fields = true
    certificates = {
      "adactimesheet.parsons.com" = {}
    }
    deletion_protection     = true
    external_tls_decryption = true
    idle_timeout            = 900
    internal                = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        default_cert_key = "adactimesheet.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-0372bda1b16b6ac07", "subnet-0bc7bb83d37b46d4b"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.224.4.45"] # Single Target does not need stickiness
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/healthcheck.htm"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-0d4892a536d91f305"
  }
}
