# Public IP Creation
resource "azurerm_public_ip" "PubIP" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"   #ensures the IP doesn’t change (fixed IP)
  sku                 = "Standard" #modern SKU that supports advanced networking & load balancers.

  tags = {
    environment = "Production"
  }
}

# Azure Network Interface Card (NIC)
resource "azurerm_network_interface" "main" {
  name                = "public-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "public-ipconfig"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PubIP.id
  }
}

# Azure VM
resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
  }

  os_profile {
    computer_name  = "linux-machine"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false # Use SSH key instead if preferred
  }

  tags = {
    environment = "Production"
  }
}
