# Declaring a module block - VPC Module
module "module_vpc" {
  source = "./modules/vpc"
  prefix = var.prefix #Prefix Name
  # vpc_cidr_block   = "10.0.0.0/16" #VPC CIDR Range
  instance_tenancy = var.instance_tenancy #Instances environment
  pub_subnet_count = var.pub_subnet_count #Total Public Subnet Count
  pvt_subnet_count = var.pvt_subnet_count #Total Private Subnet Count
  pub_azs          = var.pub_azs
  pvt_azs          = var.pvt_azs
}

module "module_ec2" {
  source          = "./modules/EC2"
  ami_id          = var.ami_id        #AMI ID
  instance_type   = var.instance_type #Instance size
  prefix          = var.prefix        #Tag Name will be added to the before resource name
  environment     = var.environment   #Environment Name i.e., Based on env type it will change the no of instances.
  sg_name         = module.module_vpc.security_group_id
  public_subnets  = module.module_vpc.public_subnets
  private_subnets = module.module_vpc.private_subnets
}

# module "module_s3" {
#   source = "./modules/S3"

# }

module "module_dns" {
  source    = "./modules/Route53"
  ipAddress = module.module_ec2.public_ip_addresses
  prefix    = module.module_vpc.prefix
}

module "module_alb" {
  source             = "./modules/ALB"
  prefix             = var.prefix
  aws_subnet_public  = module.module_vpc.public_subnets
  aws_security_group = module.module_vpc.security_group_id
  vpc_id             = module.module_vpc.vpc_id
  instance_type      = var.instance_type
  templateVersion    = var.templateVersion
  ami_id             = var.ami_id
  pub_sn             = module.module_vpc.public_subnets
  pvt_sn             = module.module_vpc.private_subnets
}
