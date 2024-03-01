# Declaring a module block - VPC Module
module "module_vpc" {
  source           = "./modules/vpc"
  prefix           = var.prefix           #Prefix Name
  vpc_cidr_block   = var.vpc_cidr_block   #VPC CIDR Range
  instance_tenancy = var.instance_tenancy #Instances environment
  az_a             = var.az_a
  az_b             = var.az_b
  az_c             = var.az_c
  pub_sn_cidr1     = var.pub_sn_cidr1
  pub_sn_cidr2     = var.pub_sn_cidr2
  pub_sn_cidr3     = var.pub_sn_cidr3
  pvt_sn_cidr3     = var.pvt_sn_cidr3
  pvt_sn_cidr1     = var.pvt_sn_cidr1
  pvt_sn_cidr2     = var.pvt_sn_cidr2
}

module "module_rds" {
  source            = "./modules/RDS"
  pub_sn_1          = module.module_vpc.public_subnet_1 # From VPC-output.tf file, we're not getting subnet id  
  pub_sn_2          = module.module_vpc.public_subnet_2 # From VPC-output.tf file, we're getting subnet id 
  pub_sn_3          = module.module_vpc.public_subnet_3 # From VPC-output.tf file, we're getting subnet id 
  prefix            = var.prefix
  vpc_id            = module.module_vpc.vpc_id
  security_group_id = module.module_vpc.security_group_id
}

# module "module_alb" {
#   source             = "./modules/ALB"
#   prefix             = var.prefix
#   aws_security_group = module.module_vpc.security_group_id
#   vpc_id             = module.module_vpc.vpc_id
#   instance_type      = var.instance_type
#   templateVersion    = var.templateVersion
#   ami_id             = var.ami_id
#   pub_sn_1           = module.module_vpc.public_subnet_1.id # From VPC-output.tf file, we're not getting subnet id  
#   pub_sn_2           = module.module_vpc.public_subnet_2    # From VPC-output.tf file, we're getting subnet id 
#   # pvt_sn_1         = module.module_vpc.private_subnet_1 # If you want to use private subnets then uncomment this
#   # pvt_sn_2         = module.module_vpc.private_subnet_2 # If you want to use private subnets then uncomment this
# }


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


# module "module_dns" {
#   source    = "./modules/Route53"
#   ipAddress = module.module_ec2.public_ip_addresses
#   prefix    = module.module_vpc.prefix
# }

# module "module_s3" {
#   source = "./modules/S3"
# }

# module "module_cloudfront" {
#   source                = "./modules/CloudFront"
#   s3_bucket_domain_name = module.module_s3.bucket_regional_domain_name
# }

