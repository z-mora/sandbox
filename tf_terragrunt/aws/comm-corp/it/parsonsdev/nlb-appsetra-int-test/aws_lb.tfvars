load_balancers = {
  "nlb-appsetra-int-test" = {
    internal            = true
    deletion_protection = true
    listeners = {
      "listener-443" = {
        port     = 443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-443"
        }
      }
      "listener-8443" = {
        port     = 8443
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-8443"
        }
      }
      "listener-8080" = {
        port     = 8080
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-8080"
        }
      }
      "listener-8181" = {
        port     = 8181
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-8181"
        }
      }
      "listener-8182" = {
        port     = 8182
        protocol = "TCP"
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-8182"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = false
    subnet_ids             = ["subnet-2b685773", "subnet-3ab5f05f"]
    target_groups = {
      "tg-nlb-port-443" = {
        port     = 443
        protocol = "TCP"
        targets  = ["i-046e588a22bc10196", "i-0bfaa86bd22a457ff"]
        type     = "instance"
        health_check = {
          port     = 443
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
      "tg-nlb-port-8443" = {
        port     = 8443
        protocol = "TCP"
        targets  = ["i-046e588a22bc10196", "i-0bfaa86bd22a457ff"]
        type     = "instance"
        health_check = {
          port     = 8443
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
      "tg-nlb-port-8080" = {
        port     = 8080
        protocol = "TCP"
        targets  = ["i-046e588a22bc10196", "i-0bfaa86bd22a457ff"]
        type     = "instance"
        health_check = {
          port     = 8080
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
      "tg-nlb-port-8181" = {
        port                       = 8181
        protocol                   = "TCP"
        targets                    = ["i-009243c0c3eeef10e", "i-0ad20471f1f10ce9c"]
        type                       = "instance"
        nlb_connection_termination = true
        health_check = {
          port     = 8181
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
      "tg-nlb-port-8182" = {
        port                       = 8182
        protocol                   = "TCP"
        targets                    = ["i-009243c0c3eeef10e", "i-0ad20471f1f10ce9c"]
        type                       = "instance"
        nlb_connection_termination = true
        health_check = {
          port     = 8182
          protocol = "TCP"
        }
        stickiness = {
          type = "source_ip"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-ce70e9a9"
  }
}
