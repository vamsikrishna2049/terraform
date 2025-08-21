variable "prefix" {
  description = "A default Prefix name will be added to all the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy resources into"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  # default     = "eastus"   # optional default
}

# Azure VNET
variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "pub_address_space" {
  description = "Address space for the Public subnet"
  type        = list(string)
  default     = ["10.0.1.0/16"]
}

variable "pvt_address_space" {
  description = "Address space for the Private subnet"
  type        = list(string)
  default     = ["10.0.10.0/16"]
}

variable "allowed_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
  default     = [22, 80, 443, 5432, 3306] #Which you want to allow
}

# Azure VM
variable "vm_size" {
  description = "The size of the Virtual Machine (e.g., Standard_DS1_v2, Standard_B2s)"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the Virtual Machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the Virtual Machine (must meet Azure complexity requirements)"
  type        = string
  sensitive   = true
}

variable "managed_disk_type" {
  description = "The type of Managed Disk to use for the VM (e.g., Standard_LRS, Premium_LRS, StandardSSD_LRS)"
  type        = string
  default     = "Standard_LRS"
}

variable "vm_name" {
  description = "Virtual Machine Name"
  type        = string
}

# Azure DNS
variable "dns_name" {
  description = "DNS zone name"
  type        = string
}