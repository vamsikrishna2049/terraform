# Declaring a module block - VPC Module
module "module_vpc" {
  source           = "./modules/vpc"
  prefix           = var.prefix           #Tag Name will be added to the before resource name
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
  prefix            = var.prefix                          #Tag Name will be added to the before resource name
  DbSG              = module.module_vpc.DbSGID            #RDS Security Group
  WebSG             = module.module_vpc.WebSG             #Web Security Group
  AppSG             = module.module_vpc.AppSGID           #App Security Group
  BastionHostSG     = module.module_vpc.BastionHostSGID   #BastionHost Security Group
  public_subnetID   = module.module_vpc.public_subnetId   #Web-AZ1-Public Subnet
  private_subnetId1 = module.module_vpc.private_subnetId1 #App-AZ1-Private Subnet
  private_subnetId2 = module.module_vpc.private_subnetId2 #RDS-Az1-Private Subnet
  private_subnetId3 = module.module_vpc.private_subnetId3 #RDS-AZ2-Private Subnet
  ami_id            = var.ami_id                          #AMI ID
  instance_type     = var.instance_type                   #Instance size
  environment       = var.environment                     #Environment Name i.e., Based on env type it will change the no of instances.
}

# Declaring a module block - RDS Module
module "module_rds" {
  source            = "./modules/RDS"
  prefix            = var.prefix                          #Tag Name will be added to the before resource name
  vpc_id            = module.module_vpc.vpc_id            #VPC ID
  security_group_id = module.module_vpc.DbSGID            #RDS Security Group
  private_subnetId2 = module.module_vpc.private_subnetId2 #Private subnet id-2 AZ-1 
  private_subnetId3 = module.module_vpc.private_subnetId3 #Private subnet id-3 AZ-2 
}
