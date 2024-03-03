variable "prefix" {
  description = "What type of module"
  type        = string
}

variable "instance_tenancy" {
  description = "instance_tenancy Type"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC Block CIDR Range"
  type        = string
}

variable "web_sn_cidr" {
  description = "Web Server - Public Subnet CIDR Range"
  type        = string
}

variable "baston_sn_cidr" {
  description = "Baston Host - Public Subnet CIDR Range"
  type        = string
}

variable "app_sn_cidr" {
  description = "App Server - Private Subnet CIDR Range"
  type        = string
}

variable "rds1_sn_cidr" {
  description = "RDS Server - Private Subnet CIDR Range"
}

variable "az_a" {
  description = "Availability Zones - 1"
  type        = string
}

variable "az_b" {
  description = "Availability Zones - 2"
  type        = string
}
