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
    environment = "Production"
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