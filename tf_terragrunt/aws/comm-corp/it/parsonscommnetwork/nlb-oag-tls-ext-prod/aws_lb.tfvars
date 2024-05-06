load_balancers = {
  "nlb-oag-tls-ext-prod" = {
    certificates = {
      "oktagateway.parsons.com"      = {}
      "archibus.parsons.com"         = {}
      "archive.parsons.com"          = {}
      "benefits.parsons.com"         = {}
      "cer.parsons.com"              = {}
      "clmmatrix.parsons.com"        = {}
      "fedtools.parsons.com"         = {}
      "fedtoolscrt.parsons.com"      = {}
      "fedtoolsdev.parsons.com"      = {}
      "mypweb.parsons.com"           = {}
      "officewebapps.parsons.com"    = {}
      "parbiztools.parsons.com"      = {}
      "pitpctools.parsons.com"       = {}
      "pweb.parsons.com"             = {}
      "pwebapi.parsons.com"          = {}
      "pwebapps.parsons.com"         = {}
      "pwebhseowa.parsons.com"       = {}
      "pwebteam.parsons.com"         = {}
      "pwebtools.parsons.com"        = {}
      "pwebtoolscrt2012.parsons.com" = {}
      "pwebtoolstst2012.parsons.com" = {}
      "qabenefits.parsons.com"       = {}
      "qamysite.parsons.com"         = {}
      "qapweb.parsons.com"           = {}
      "qapwebapps.parsons.com"       = {}
      "qapwebteam.parsons.com"       = {}
      "testpweb.parsons.com"         = {}
      "webtime.parsons.com"          = {}
      "webtimecrt2012.parsons.com"   = {}
    }
    internal = false
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "TLS"
        default_cert_key = "oktagateway.parsons.com"
        secondary_cert_keys = [
          "archibus.parsons.com",
          "archive.parsons.com",
          "benefits.parsons.com",
          "cer.parsons.com",
          "clmmatrix.parsons.com",
          "fedtools.parsons.com",
          "fedtoolscrt.parsons.com",
          "fedtoolsdev.parsons.com",
          "mypweb.parsons.com",
          "officewebapps.parsons.com",
          "parbiztools.parsons.com",
          "pitpctools.parsons.com",
          "pweb.parsons.com",
          "pwebapi.parsons.com",
          "pwebapps.parsons.com",
          "pwebhseowa.parsons.com",
          "pwebteam.parsons.com",
          "pwebtools.parsons.com",
          "pwebtoolscrt2012.parsons.com",
          "pwebtoolstst2012.parsons.com",
          "qabenefits.parsons.com",
          "qamysite.parsons.com",
          "qapweb.parsons.com",
          "qapwebapps.parsons.com",
          "qapwebteam.parsons.com",
          "testpweb.parsons.com",
          "webtime.parsons.com",
          "webtimecrt2012.parsons.com"
        ]
        default_action = {
          type             = "forward"
          target_group_key = "tg-nlb-port-11054"
        }
      }
    }
    nlb_network_cross_zone = true
    redirect_80_to_443     = true
    subnet_ids             = ["subnet-06bcb8d36f20ba24e", "subnet-04030635e8ee35895"]
    target_groups = {
      "tg-nlb-port-11054" = {
        port     = 11054
        protocol = "TCP"
        targets  = ["i-0ec595648d0494e01", "i-00bc3b08a55f95ed4"]
        type     = "instance"
        health_check = {
          port     = 11054
          protocol = "TCP"
        }
      }
    }
    type   = "network"
    vpc_id = "vpc-0f33b8af8702635e7"
  }
}
