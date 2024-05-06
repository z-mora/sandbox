load_balancers = {
  "lb-ci-ad-tips-dev-arcgis-ext-01" = {
    backend_pool_addresses = {
      "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01" = {
        backend_ip_address        = "10.208.2.4"
        backend_pool_address_name = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01"
      }
      "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-02" = {
        backend_ip_address        = "10.208.2.5"
        backend_pool_address_name = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-ci-ad-tips-dev-arcgis-ext-backend-pool-01"
    frontend_name        = "lb-ci-ad-tips-dev-arcgis-ext-frontend-01"
    frontend_subnet      = "subnet-palo_untrust-prod-01"
    internal_or_external = "external"
    load_balancer_rules = {
      "lb-ci-ad-tips-dev-arcgis-ext-rule-01" = {
        backend_port          = 20020
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-ad-tips-dev-arcgis-ext-probe-01"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
    }
    location             = "eastus2"
    public_ip_name       = "pip-ci-ad-tips-dev-arcgis-ext-01"
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
  "lb-ci-inet-dev-jenkins-ext-01" = {
    backend_pool_addresses = {
      "lb-ci-inet-dev-jenkins-ext-backend-pool-01" = {
        backend_ip_address        = "10.208.2.4"
        backend_pool_address_name = "lb-ci-inet-dev-jenkins-ext-backend-pool-01"
      }
      "lb-ci-inet-dev-jenkins-ext-backend-pool-02" = {
        backend_ip_address        = "10.208.2.5"
        backend_pool_address_name = "lb-ci-inet-dev-jenkins-ext-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-ci-inet-dev-jenkins-ext-backend-pool-01"
    frontend_name        = "lb-ci-inet-dev-jenkins-ext-frontend-01"
    frontend_subnet      = "subnet-palo_untrust-prod-01"
    internal_or_external = "external"
    load_balancer_rules = {
      "lb-ci-inet-dev-jenkins-ext-rule-01" = {
        backend_port          = 20000
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-01"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-02" = {
        backend_port          = 20001
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8444
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-02"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-03" = {
        backend_port          = 20002
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8445
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-03"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-04" = {
        backend_port          = 20003
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8446
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-04"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-05" = {
        backend_port          = 20004
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8447
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-05"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-06" = {
        backend_port          = 20005
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8448
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-06"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-07" = {
        backend_port          = 20006
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8449
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-07"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-08" = {
        backend_port          = 20007
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8450
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-08"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-09" = {
        backend_port          = 20008
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8451
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-09"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-10" = {
        backend_port          = 20009
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8452
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-10"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-11" = {
        backend_port          = 20010
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8453
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-11"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "lb-ci-inet-dev-jenkins-ext-rule-12" = {
        backend_port          = 20011
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8454
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-ci-inet-dev-jenkins-ext-probe-12"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
    }
    location             = "eastus2"
    public_ip_name       = "pip-ci-inet-dev-jenkins-ext-01"
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
  "lb-paloalto-westus2-ilb-01" = {
    backend_pool_addresses = {
      "lb-paloalto-westus2-ilb-backend-pool-01" = {
        backend_ip_address        = "10.210.2.132"
        backend_pool_address_name = "lb-paloalto-westus2-ilb-backend-pool-01"
      }
      "lb-paloalto-westus2-ilb-backend-pool-02" = {
        backend_ip_address        = "10.210.2.133"
        backend_pool_address_name = "lb-paloalto-westus2-ilb-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-paloalto-westus2-ilb-backend-pool-01"
    frontend_name        = "lb-paloalto-westus2-ilb-frontend-01"
    frontend_subnet      = "subnet-westus2-palo_trust-prod-01"
    internal_or_external = "internal"
    load_balancer_rules = {
      "lb-paloalto-westus2-ilb-rule-01" = {
        backend_port          = 0
        disable_outbound_snat = true
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 0
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-paloalto-westus2-ilb-probe-01"
        probe_number          = 2
        probe_port            = 443
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "All"
      }
    }
    location             = "westus2"
    public_ip_name       = ""
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-westus2-firewall-prod-01"
  }
}
