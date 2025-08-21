output "deployment_info" {
  description = "Infra Deployment details"
  value = {
    vnet_name             = azurerm_virtual_network.vnet.name
    vm_name               = azurerm_virtual_machine.main.name
    vm_public_ip          = azurerm_public_ip.PubIP.ip_address
    ssh_connection_string = "Connect via -> ssh testadmin@${azurerm_public_ip.PubIP.ip_address}"
    AType_dns_name =  azurerm_dns_a_record.A1Rec.name
  }
}