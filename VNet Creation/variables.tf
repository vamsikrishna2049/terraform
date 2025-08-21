variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  # default     = "eastus"   # optional default
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy resources into"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "prefix" {
  description = "A default Prefix name will be added to all the resources"
  type        = string
}