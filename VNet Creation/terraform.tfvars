prefix = "Test"

#Resource Group
resource_group_name = "1-b4f8b332-playground-sandbox"
location            = "southcentralus"

#Networking
vnet_address_space = ["10.0.0.0/16"]
pub_address_space  = ["10.0.1.0/24"]
pvt_address_space  = ["10.0.10.0/24"]

allowed_ports=[22, 80, 443, 5432, 3306]