load_balancers = {
  "lb-paloalto-usgovvirginia-ilb-01" = {
    backend_pool_addresses = {
      "lb-paloalto-eastus2-ilb-backend-pool-01" = {
        backend_ip_address        = "10.216.2.133"
        backend_pool_address_name = "lb-paloalto-usgovvirginia-ilb-backend-pool-01"
      }
      "lb-paloalto-eastus2-ilb-backend-pool-02" = {
        backend_ip_address        = "10.216.2.132"
        backend_pool_address_name = "lb-paloalto-usgovvirginia-ilb-backend-pool-02"
      }
    }
    backend_pool_name    = "lb-paloalto-usgovvirginia-ilb-backend-pool-01"
    frontend_name        = "lb-paloalto-usgovvirginia-ilb-frontend-01"
    frontend_subnet      = "subnet-palo_trust-prod-01"
    internal_or_external = "internal"
    load_balancer_rules = {
      "lb-paloalto-usgovvirginia-ilb-rule-01" = {
        backend_port          = 0
        disable_outbound_snat = true
        enable_floating_ip    = false
        enable_tcp_reset      = false
        frontend_port         = 0
        idle_timeout          = 10
        load_distribution     = "SourceIP"
        probe_interval        = 5
        probe_name            = "lb-paloalto-usgovvirginia-ilb-probe-01"
        probe_number          = 2
        probe_port            = 443
        probe_protocol        = "Tcp"
        probe_request_path    = ""
        protocol              = "All"
      }
    }
    location             = "usgovvirginia"
    public_ip_name       = ""
    resource_group_name  = "rg-network-prod-01"
    sku                  = "Standard"
    virtual_network_name = "vnet-firewall-prod-01"
    zones                = [1, 2, 3]
  }
}
