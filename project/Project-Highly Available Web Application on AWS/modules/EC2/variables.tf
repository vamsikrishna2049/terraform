variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "environment" {
  description = "Type of Environment"
  type        = string
}

variable "sg_name" {
  description = "VPC Security Group"
  type        = string
}

variable "prefix" {
  description = "Name of the module"
  type        = string
}

variable "public_subnets" {}
variable "private_subnets" {}