load_balancers = {
  "alb-sqlkinect-tls-dmz-prod" = {
    certificates = {
      "sqlkinect.parsons.com"    = {}
      "sqlkinectcan.parsons.com" = {}
    }
    deletion_protection            = false
    alb_drop_invalid_header_fields = true
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "HTTPS"
        default_cert_key    = "sqlkinect.parsons.com"
        secondary_cert_keys = ["sqlkinectcan.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-0ee5ec08b6c0a41d1", "subnet-01cdba01c51b4030b"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.41.128.149"] # Single Target does not need stickiness
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
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
