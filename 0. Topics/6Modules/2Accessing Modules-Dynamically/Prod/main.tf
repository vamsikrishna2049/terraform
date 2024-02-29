# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

terraform {
  required_version = "<=1.6.6" #This terraform code is compatible till 1.6.6
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Declaring a module block - VPC Module
module "module_vpc" {
  source           = "./modules/vpc"
  module_name      = "prod"        # Type of module based on this prefix will be added infront of tags
  vpc_cidr_block   = "10.0.0.0/16" # VPC CIDR Range
  instance_tenancy = "default"     #Instance tenancy Type
  pub_subnet_count = 1             #Public Subnet count
  #pub_subnet_cidr_block will create dynamically
  pub_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  pvt_subnet_count      = 3 # This value must be matched with pvt_subnet_cidr_block
  pvt_subnet_cidr_block = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  pvt_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}


# # Declaring a module block - VPC Module
# module "dev_infra2" {
#   source                = "../modules/VPC"
#   module_name           = "dev_infra2"   # Type of module based on this prefix will be added in front of tags
#   vpc_cidr_block        = "10.20.0.0/16" # VPC CIDR Range
#   instance_tenancy      = "default"      # Instance tenancy Type
#   pub_subnet_count      = 3              # Public Subnet count
#   pub_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]  # Constant availability zones
#   pvt_subnet_count      = 3              # This value must be matched with pvt_subnet_cidr_block
#   pvt_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
# }

#Note
# If you want to create subnets dynamically and azs are constant then use above block. In the subnets section use below block of code.

# # Creating - public subnets
# resource "aws_subnet" "pub_sn" {
#   count                   = var.pub_subnet_count
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = element(var.pub_subnet_cidr_block, count.index % length(var.pub_subnet_cidr_block))
#   availability_zone       = element(module.dev_infra2.pub_azs, count.index % length(module.dev_infra2.pub_azs))
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${module.dev_infra2.module_name}-pub-sn-${count.index + 1}"
#   }
# }
