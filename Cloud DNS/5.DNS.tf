# DNS Zone
resource "azurerm_dns_zone" "dns" {
  name                = var.dns_name # Your domain
  resource_group_name = var.resource_group_name
}

# Example A Record
resource "azurerm_dns_a_record" "A1Rec" {
  name                = "nginx"
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_public_ip.PubIP.ip_address]
}