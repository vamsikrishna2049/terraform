#variables declaration here
variable "region" {}
variable "instance_type" {}

#Red VPC
variable "red_vpc" {}
variable "red_vpc_cidr_block" {}
variable "red_subnet_count" {}
variable "red_subnet_cidr_block" {}
variable "red_subnet_az" {}
variable "red_rhel_ami_id" {}

#White VPC
variable "white_vpc" {}
variable "white_vpc_cidr_block" {}
variable "white_subnet_cidr_block" {}
variable "white_subnet_az" {}
variable "white_ubuntu_ami_id" {}
variable "white_subnet_count" {}
