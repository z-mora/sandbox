load_balancers = {
  "alb-ntlgis-tls-dmz-dev" = {
    certificates = {
      "ntlgis.parsons.com" = {}
    }
    alb_drop_invalid_header_fields = true
    external_tls_decryption        = true
    internal                       = true
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "HTTPS"
        # target_group_key = "tg-port-443"
        default_cert_key = "ntlgis.parsons.com"
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-031ff3395ce062232", "subnet-0cb65c367898fe61a"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.191.10.120"] # Single Target does not need stickiness
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
    vpc_id = "vpc-03167ea3e6580f6b5"
  }
}
