#variables declaration here
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "pub_subnet_count" {}
variable "pub_subnet_cidr_block" {}
variable "azs" {}
variable "pvt_subnet_count" {}
variable "pvt_subnet_cidr_block" {}
# variable "ami_id" {}
variable "amis" {}
variable "region" {}
variable "profile" {}

variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "key_name" {}
