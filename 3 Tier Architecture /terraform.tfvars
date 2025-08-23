prefix = "Test"
tags   = "Test"

# Resource Group
resource_group_name = "1-4cdf1f1f-playground-sandbox"
location            = "WestUS"

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

# Storage Account Name
storage_account_name = "ms1az13user3tetsstorage"