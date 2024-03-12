variable "prefix" {
  description = "Prefix name will be added infront of all the resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC where the resources will be deployed"
  type        = string
}

variable "instance_tenancy" {
  description = "The tenancy of the instance (default, dedicated, or host)"
  type        = string
}

variable "az_a" {
  description = "Availability Zone A for deployment"
  type        = string
}

variable "az_b" {
  description = "Availability Zone B for deployment"
  type        = string
}

variable "pub_sn" {
  description = "Public subnet ID for Web Server"
  type        = string
}

variable "pvt_sn1" {
  description = "Private subnet 1 ID for App Host"
  type        = string
}

variable "pvt_sn2" {
  description = "Private subnet 2 ID for RDS1 Server"
  type        = string
}

variable "pvt_sn3" {
  description = "Private subnet 3 ID for  RDS2 Server"
  type        = string
}
