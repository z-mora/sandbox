load_balancers = {
  "alb-jazz-tls-dmz-prod" = {
    alb_drop_invalid_header_fields = false
    certificates = {
      "jazz.parsons.com" = {}
    }
    deletion_protection     = true
    desync_mitigation_mode  = "monitor"
    external_tls_decryption = true
    idle_timeout            = 900
    internal                = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        default_cert_key = "jazz.parsons.com"
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
        targets                         = ["10.41.128.121"] # Single Target does not need stickiness
        type                            = "ip"
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/jts/auth/authrequired"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
