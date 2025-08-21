prefix = "Test"

# Resource Group
resource_group_name = "1-3c12e2a9-playground-sandbox"
location            = "EastUS"

# Azure Virtual Network
vnet_address_space = ["10.0.0.0/16"]
pub_address_space  = ["10.0.1.0/24"]
pvt_address_space  = ["10.0.10.0/24"]
allowed_ports      = [22, 80, 443, 5432, 3306]

# Azure Virtual Machines
admin_username    = "testadmin"
admin_password    = "Password1234!"
vm_size           = "Standard_DS1_v2"
vm_name           = "TestMachine"
managed_disk_type = "Standard_LRS"


# Azure DNS
dns_name = "practisedomain.cloud"
