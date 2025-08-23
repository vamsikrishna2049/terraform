output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.db.fqdn
}

output "mysql_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "deployment_info" {
  description = "Infra Deployment details"
  value = {
    vnet_name             = azurerm_virtual_network.vnet.name
    vm_name               = azurerm_virtual_machine.main.name
    vm_public_ip          = azurerm_public_ip.PubIP.ip_address
    ssh_connection_string = "ssh testadmin@${azurerm_public_ip.PubIP.ip_address}"
  }
}