# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}

terraform {
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
  module_name      = "dev"         #Environment Name
  vpc_cidr_block   = "10.0.0.0/16" #VPC CIDR Range
  instance_tenancy = "default"     #Instances environment
  pub_azs          = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  pvt_azs          = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  pub_subnet_count = 4 #Total Public Subnet Count
  pvt_subnet_count = 1 #Total Private Subnet Count
}

module "module_ec2" {
  source                             = "./modules/EC2"
  ami_id                             = "ami-0ad86651279e2c354" #Instance Type
  instance_type                      = "t2.micro"              #Instance size
  prefix                             = "dev"                   #Environment Name
  pub_instance_count                 = 1                       #Tot no of pvt instances required
  pvt_instance_count                 = 4                       #Tot no of pub instances required
  vpc_cidr_block                     = module.module_vpc.vpc_cidr_block
  pub_subnet_count                   = module.module_vpc.pub_subnet_count
  pvt_subnet_count                   = module.module_vpc.pvt_subnet_count
  module_name                        = module.module_vpc.module_name
  private_subnets_availability_zones = module.module_vpc.private_subnets_availability_zones
  public_subnets_availability_zones  = module.module_vpc.public_subnets_availability_zones
}
