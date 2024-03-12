# Declaring a module block - VPC Module
module "module_vpc" {
  source           = "./modules/vpc"
  prefix           = var.prefix           #Prefix Name
  instance_tenancy = var.instance_tenancy #Instances environment
  vpc_cidr_block   = var.vpc_cidr_block   #VPC CIDR Range
  az_a             = var.az_a             #Availability Zone -1
  az_b             = var.az_b             #Availability Zone -2
  pub_sn           = var.pub_sn           #Availability Zone -1 Public CIDR Range
  pvt_sn1          = var.pvt_sn1          #Availability Zone -1 Private CIDR Range
  pvt_sn2          = var.pvt_sn2          #Availability Zone -1 Private CIDR Range
  pvt_sn3          = var.pvt_sn3          #Availability Zone -2 Private CIDR Range
}

# Declaring a module block - EC2 Module
module "module_ec2" {
  source            = "./modules/EC2"
  ami_id            = var.ami_id        #AMI ID
  instance_type     = var.instance_type #Instance size
  prefix            = var.prefix        #Tag Name will be added to the before resource name
  environment       = var.environment   #Environment Name i.e., Based on env type it will change the no of instances.
  DbSG              = module.module_vpc.DbSGID
  WebSG             = module.module_vpc.WebSG
  AppSG             = module.module_vpc.AppSGID
  BastionHostSG     = module.module_vpc.BastionHostSGID
  public_subnetID   = module.module_vpc.public_subnetId
  private_subnetId1 = module.module_vpc.private_subnetId1
  private_subnetId2 = module.module_vpc.private_subnetId2
  private_subnetId3 = module.module_vpc.private_subnetId3
}

# Declaring a module block - RDS Module
module "module_rds" {
  source            = "./modules/RDS"
  private_subnetId2 = module.module_vpc.private_subnetId2 # From VPC-output.tf file, we're getting subnet id  
  private_subnetId3 = module.module_vpc.private_subnetId3 # From VPC-output.tf file, we're getting subnet id 
  prefix            = var.prefix
  vpc_id            = module.module_vpc.vpc_id
  security_group_id = module.module_vpc.DbSGID
}
