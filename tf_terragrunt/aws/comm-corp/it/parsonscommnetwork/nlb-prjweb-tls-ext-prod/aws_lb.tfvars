load_balancers = {
  "nlb-prjweb-tls-ext-prod" = {
    certificates = {
      "pmhelp.parsons.com"          = {}
      "aimsbarcode.parsons.com"     = {}
      "cftwebapiext.parsons.com"    = {}
      "cftwebapiuatext.parsons.com" = {}
      "exiparsons.com" = {
        subject_alternative_names = ["www.exiparsons.com"]
      }
      "njinspections.com" = {
        subject_alternative_names = ["www.njinspections.com"]
      }
      "njinspection.com" = {
        subject_alternative_names = ["www.njinspection.com"]
      }
      "route45project.com" = {
        subject_alternative_names = ["www.route45project.com"]
      }
      "seaporte.parsons.com" = {}
      "project1.parsons.com" = {}
    }
    internal = false
    listeners = {
      "listener-443" = {
        port                = 443
        protocol            = "TLS"
        default_cert_key    = "pmhelp.parsons.com"
        secondary_cert_keys = ["exiparsons.com", "cftwebapiext.parsons.com", "cftwebapiuatext.parsons.com", "njinspections.com", "njinspection.com", "aimsbarcode.parsons.com", "route45project.com", "seaporte.parsons.com", "project1.parsons.com"]
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11039"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-06bcb8d36f20ba24e", "subnet-04030635e8ee35895"]
    target_groups = {
      "tg-nlb-port-11039" = {
        port     = 11039
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11039
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0f33b8af8702635e7"
  }
}
