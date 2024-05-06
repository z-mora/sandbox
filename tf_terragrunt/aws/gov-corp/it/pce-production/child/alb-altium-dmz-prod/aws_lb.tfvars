load_balancers = {
  "alb-altium-dmz-prod" = {
    alb_drop_invalid_header_fields = false
    alb_fips                       = true
    certificates = {
      "altiument.parsons.com" = {}
    }
    deletion_protection     = true
    external_tls_decryption = false
    idle_timeout            = 120
    internal                = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        default_cert_key = "altiument.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-01966d52fac928fc5", "subnet-0ab6dd0eaa607b8c0"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.33.152.180"]
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          matcher  = "200,301,302"
          path     = "/"
          port     = 443
          protocol = "HTTPS"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-0f76390d89c8532b7"
  }
}
