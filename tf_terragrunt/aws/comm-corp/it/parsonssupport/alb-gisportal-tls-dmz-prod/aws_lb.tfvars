load_balancers = {
  "alb-gisportal-tls-dmz-prod" = {
    certificates = {
      "gisportal.parsons.com" = {}
    }
    deletion_protection            = false
    alb_drop_invalid_header_fields = true
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "HTTPS"
        # target_group_key = "tg-port-443"
        default_cert_key = "gisportal.parsons.com"
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
        targets                         = ["10.41.129.26"] # Single Target does not need stickiness
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
