# Declaring a module block - VPC Module
module "module_vpc" {
  source           = "./modules/vpc"
  prefix           = var.prefix           #Prefix Name
  vpc_cidr_block   = var.vpc_cidr_block   #VPC CIDR Range
  instance_tenancy = var.instance_tenancy #Instances environment
  az_a             = var.az_a             #Availability Zone -1
  az_b             = var.az_b             #Availability Zone -2
  web_sn_cidr      = var.web_sn_cidr      #Availability Zone -1 Public CIDR Range
  baston_sn_cidr   = var.baston_sn_cidr   #Availability Zone -1 Private CIDR Range
  app_sn_cidr      = var.app_sn_cidr      #Availability Zone -1 Private CIDR Range
  rds1_sn_cidr     = var.rds1_sn_cidr     #Availability Zone -1 Private CIDR Range
  rds2_sn_cidr     = var.rds2_sn_cidr     #Availability Zone -2 Private CIDR Range
}

# # Declaring a module block - EC2 Module
# module "module_ec2" {
#   source         = "./modules/EC2"
#   ami_id         = var.ami_id        #AMI ID
#   instance_type  = var.instance_type #Instance size
#   prefix         = var.prefix        #Tag Name will be added to the before resource name
#   environment    = var.environment   #Environment Name i.e., Based on env type it will change the no of instances.
#   sg_name        = module.module_vpc.security_group_id
#   public_subnet1 = module.module_vpc.public_subnet_1
#   public_subnet2 = module.module_vpc.public_subnet_2
# }

# # Declaring a module block - RDS Module
# module "module_rds" {
#   source            = "./modules/RDS"
#   pub_sn_1          = module.module_vpc.public_subnet_1 # From VPC-output.tf file, we're getting subnet id  
#   pub_sn_2          = module.module_vpc.public_subnet_2 # From VPC-output.tf file, we're getting subnet id 
#   pub_sn_3          = module.module_vpc.public_subnet_3 # From VPC-output.tf file, we're getting subnet id 
#   prefix            = var.prefix
#   vpc_id            = module.module_vpc.vpc_id
#   security_group_id = module.module_vpc.security_group_id
# }
