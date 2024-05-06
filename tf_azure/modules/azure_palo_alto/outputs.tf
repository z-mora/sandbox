output "id" {
  description = "The ID of the virtual machine"
  value       = azurerm_virtual_machine.this.id
}

output "interface_ips" {
  description = "Map of interfaces and their IPs"
  value = {
    for k, v in azurerm_network_interface.this : k => {
      private_ip_address = v.private_ip_address
      public_ip_address  = try(azurerm_public_ip.this[k].ip_address, "N/A")
    }
  }
}
