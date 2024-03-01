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

variable "pub_sn_cidr1" {
  description = "Public Availability Zones"
  type        = string
}

variable "az_a" {
  description = "Public Availability Zones"
  type        = string
}

variable "pub_sn_cidr2" {
  description = "Availability Zones"
  type        = string
}

variable "pub_sn_cidr3" {
  description = "Availability Zones"
  type        = string
}

variable "az_b" {
  description = "Availability Zones"
  type        = string
}

variable "az_c" {
  description = "Availability Zones"
  type        = string
}

variable "pvt_sn_cidr1" {
  description = "Private Availability Zone"
  type        = string
}

variable "pvt_sn_cidr2" {
  description = "Availability Zones"
  type        = string
}

variable "pvt_sn_cidr3" {
  description = "Availability Zones"
  type        = string
}
