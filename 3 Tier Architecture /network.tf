# VNET Creation
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags = {
    environment = var.tags
  }
}

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

# Route Table
resource "azurerm_route_table" "route_table" {
  name                = "${var.prefix}-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name           = "internet-route"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags = {
    environment = var.tags
  }
}

# Route Table Association - Public
resource "azurerm_subnet_route_table_association" "public" {
  subnet_id      = azurerm_subnet.public.id
  route_table_id = azurerm_route_table.route_table.id
}

# Route Table Association - Private
resource "azurerm_subnet_route_table_association" "private" {
  subnet_id      = azurerm_subnet.private.id
  route_table_id = azurerm_route_table.route_table.id
}

# VNet NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.allowed_ports
    content {
      name                       = "Allow-Port-${security_rule.value}"
      priority                   = 100 + index(var.allowed_ports, security_rule.value) * 10
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = {
    environment = var.tags
  }
}

# NSG Association to Subnets - Public
resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# NSG Association to Subnets - Private
resource "azurerm_subnet_network_security_group_association" "private_nsg_association" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}