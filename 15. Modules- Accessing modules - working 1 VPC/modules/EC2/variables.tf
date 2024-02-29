variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "pub_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "pvt_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

variable "prefix" {
  description = "Name of the module"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets_availability_zones" {
  description = "value"
  type        = list(string)
}

variable "private_subnets_availability_zones" {
  description = "value"
  type        = list(string)
}

variable "pub_instance_count" {
  description = "Total number of public instances required"
  type        = number
}

variable "pvt_instance_count" {
  description = "Total number of private instances required"
  type        = number
}
