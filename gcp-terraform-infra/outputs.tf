variable "project_id" {}
variable "project_name" {}
variable "billing_account" {}
variable "org_id" {}

variable "region" {
  default = "asia-south1"
}

variable "zone" {
  default = "asia-south1-a"
}

variable "vpc_name" {
  default = "custom-vpc"
}

variable "subnet_name" {
  default = "custom-subnet"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "instance_name" {
  default = "vm-instance"
}

variable "machine_type" {
  default = "e2-medium"
}