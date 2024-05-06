load_balancers = {
  "alb-gisportaltest-tls-dmz-test" = {
    certificates = {
      "gisportaltest.parsons.com" = {}
    }
    deletion_protection            = false
    alb_drop_invalid_header_fields = true
    external_tls_decryption        = true
    alb_fips                       = false
    internal                       = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        target_group_key = "tg-port-443"
        default_cert_key = "gisportaltest.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-0fddcd94fb3d33488", "subnet-0a4b459e2e504fe33"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.41.94.57"] # Single Target does not need stickiness
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
    vpc_id = "vpc-0b7d2a1906bc20700"
  }
}
