load_balancers = {
  "alb-pwisegwebdr-tls-dmz-dr" = {
    certificates = {
      "pwisegwebdr.parsons.com" = {}
    }
    deletion_protection            = true
    alb_drop_invalid_header_fields = false
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        default_cert_key = "pwisegwebdr.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-0fe5d1b311444568c", "subnet-0ef1fc938883bf005"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.44.17.174"] # Single Target does not need stickiness
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
    vpc_id = "vpc-020c7777bdc439066"
  }
}
