variable "prefix" {
  description = "What type of module"
  type        = string
}

variable "aws_subnet_public" {
  type    = list(string)
  default = [] # Provide a default value if necessary
}

variable "aws_security_group" {
  type    = string
  default = "" # Provide a default value if necessary
}

variable "vpc_id" {}
variable "instance_type" {}
variable "templateVersion" {}
variable "ami_id" {}
variable "pub_sn" {}
variable "pvt_sn" {}
