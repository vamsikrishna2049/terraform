#VPC-Variables
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "enable_dns_hostnames" {}
variable "instance_tenancy" {}
#Public subnet-Variables
variable "azs" {}
variable "pub_subnet_count" {}

variable "pub_subnet_cidr_block" {}
#Private subnet-Variables
variable "pvt_subnet_cidr_block" {}
variable "pvt_subnet_count" {
  type    = number
  default = 1  # This is the default value, but it will be overridden by the value in terraform.tfvars.
}


#EC2 Instance Type
variable "ami_id" {}
