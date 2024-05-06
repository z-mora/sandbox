load_balancers = {
  "lb-inf-ipkeys-cyberzcape-prod-ext-01" = {
    backend_pool_addresses = {
      "lb-inf-ipkeys-cyberzcape-prod-ext-backend-pool-01" = {
        backend_ip_address        = "10.208.2.4"
        backend_pool_address_name = "lb-inf-ipkeys-cyberzcape-prod-ext-backend-pool-01"
      }
      "lb-inf-ipkeys-cyberzcape-prod-ext-backend-pool-02" = {
        backend_ip_address        = "10.208.2.5"
        backend_pool_address_name = "lb-inf-ipkeys-cyberzcape-prod-ext-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-inf-ipkeys-cyberzcape-prod-ext-backend-pool-01"
    frontend_name        = "lb-inf-ipkeys-cyberzcape-prod-ext-frontend-01"
    frontend_subnet      = "subnet-palo_untrust-prod-01"
    internal_or_external = "external"
    load_balancer_rules = {
      "tcp-80-to-20022" = {
        backend_port          = 20022
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 80
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-inf-ipkeys-cyberzcape-prod-ext-probe-01"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "tcp-443-to-20023" = {
        backend_port          = 20023
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-inf-ipkeys-cyberzcape-prod-ext-probe-02"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "tcp-8443-to-20024" = {
        backend_port          = 20024
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-inf-ipkeys-cyberzcape-prod-ext-probe-03"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Tcp"
      }
      "udp-8443-to-20025" = {
        backend_port          = 20025
        disable_outbound_snat = false
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 8443
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-inf-ipkeys-cyberzcape-prod-ext-probe-03"
        probe_number          = 2
        probe_port            = 22
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "Udp"
      }
    }
    location             = "eastus2"
    public_ip_name       = "pip-inf-ipkeys-cyberzcape-prod-ext-01"
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
  }
}
