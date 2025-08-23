# Random Password
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Subnet for MySQL
resource "azurerm_subnet" "db" {
  name                 = "db-pvt-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]

  delegation {
    name = "mysql_delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
      ]
    }
  }
}

# Private DNS Zone for MySQL
resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_subnet.db]
  tags = {
    environment = var.tags
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_link" {
  name                  = "mysql-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  tags = {
    environment = var.tags
  }
}

resource "azurerm_mysql_flexible_server" "db" {
  name                = "tf-mysql-db"
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login    = "dbadmin"
  administrator_password = random_password.db_password.result

  sku_name              = "B_Standard_B1ms"
  version               = "5.7"
  backup_retention_days = 7

  delegated_subnet_id = azurerm_subnet.db.id
  private_dns_zone_id = azurerm_private_dns_zone.mysql.id

  storage {
    size_gb = 32
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.mysql_link
  ]

  tags = {
    environment = var.tags
  }
}