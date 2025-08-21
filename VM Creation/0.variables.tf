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
