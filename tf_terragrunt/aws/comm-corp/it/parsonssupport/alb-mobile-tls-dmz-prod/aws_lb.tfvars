load_balancers = {
  "alb-mobile-tls-dmz-prod" = {
    certificates = {
      "mobile.parsons.com" = {}
      "contractorsafetyforms.com" = {
        subject_alternative_names = ["www.contractorsafetyforms.com"]
      }
      "marigoldinfrastructurepartners.com" = {
        subject_alternative_names = ["www.marigoldinfrastructurepartners.com"]
      }
    }
    alb_drop_invalid_header_fields = false
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "HTTPS"
        default_cert_key    = "mobile.parsons.com"
        secondary_cert_keys = ["contractorsafetyforms.com", "marigoldinfrastructurepartners.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-80"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-0ee5ec08b6c0a41d1", "subnet-01cdba01c51b4030b"]
    target_groups = {
      "tg-port-80" = {
        port                            = 80
        protocol                        = "HTTP"
        targets                         = ["10.41.129.214"]
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/healthcheck.htm"
          port     = 80
          protocol = "HTTP"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-077a49cbe56a4076e"
  }
}
