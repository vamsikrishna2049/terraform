variable "prefix" {
  description = "Prefix name will be added infront of all the resources"
  type        = string
}

variable "WebSG" {
  description = "Web Security Group"
  type        = string
}

variable "BastionHostSG" {
  description = "Bastion Host Security Group"
  type        = string
}

variable "AppSG" {
  description = "App Security Group"
  type        = string
}

variable "DbSG" {
  description = "Database Security Group"
  type        = string
}

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


variable "public_subnetID" {
  description = "Public Subnet ID"
  type        = string
}

variable "private_subnetId1" {
  description = "Private Subnet ID1"
  type        = string
}

variable "private_subnetId2" {
  description = "Private Subnet ID2"
  type        = string
}

variable "private_subnetId3" {
  description = "Private Subnet ID3"
  type        = string
}
