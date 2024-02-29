# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

terraform {
  required_version = "<=1.6.6"
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
  module_name      = "dev"         # Type of module based on this prefix will be added infront of tags
  vpc_cidr_block   = "10.0.0.0/16" # VPC CIDR Range
  instance_tenancy = "default"     #Instance tenancy Type
  pub_subnet_count = 1             #Public Subnet count
  #pub_subnet_cidr_block will create dynamically
  pub_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  pvt_subnet_count      = 3 # This value must be matched with pvt_subnet_cidr_block
  pvt_subnet_cidr_block = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  pvt_azs               = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}
