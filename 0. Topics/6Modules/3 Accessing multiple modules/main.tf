# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
  alias      = "default"
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
  prefix           = "dev"         #Environment Name
  vpc_cidr_block   = "10.0.0.0/16" #VPC CIDR Range
  instance_tenancy = "default"     #Instances environment
  pub_azs          = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  pvt_azs          = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  pub_subnet_count = 4 #Total Public Subnet Count
  pvt_subnet_count = 1 #Total Private Subnet Count

}

module "module_ec2" {
  source        = "./modules/EC2"
  ami_id        = "ami-01e82af4e524a0aa3" #Instance Type
  instance_type = "t2.micro"              #Instance size
  prefix        = "dev"                   #Environment Name
  environment   = "test"
  sg_name        = module.module_vpc.security_group_id
  public_subnets = module.module_vpc.public_subnets
}


# module "module_ec2" {
#   source         = "./module/EC2"
#   ami_id         = "ami-01e82af4e524a0aa3" #Instance Type
#   instance_type  = "t2.micro"              #Instance size
#   prefix         = "dev"                   #Environment Name
#   environment    = "test"
# sg_name        = module_vpc.security_group_id
# public_subnets = module_vpc.public_subnets
# }
