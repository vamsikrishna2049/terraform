#Subnet Creation - Public
resource "azurerm_subnet" "public" {
  name                 = "${var.prefix}-pub-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pub_address_space
}

#Subnet Creation - Private
resource "azurerm_subnet" "private" {
  name                 = "${var.prefix}-pvt-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pvt_address_space
}