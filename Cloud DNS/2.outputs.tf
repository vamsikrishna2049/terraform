output "deployment_info" {
  description = "Infra Deployment details"
  value = {
    vnet_name             = azurerm_virtual_network.vnet.name
    vm_name               = azurerm_virtual_machine.main.name
    vm_public_ip          = azurerm_public_ip.PubIP.ip_address
    ssh_connection_string = "ssh testadmin@${azurerm_public_ip.PubIP.ip_address}"
  }
}