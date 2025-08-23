output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.db.fqdn
}

output "mysql_password" {
  value     = random_password.db_password.result
  sensitive = true
}
