#################### VPC ####################
#VPC ID
output "vpc_id" {
  value = module.module_vpc.vpc_id
}

#Public Subnets ID
output "public_subnet_1" {
  value = module.module_vpc.public_subnet_1
}

output "public_subnet_2" {
  value = module.module_vpc.public_subnet_2
}

output "public_subnet_3" {
  value = module.module_vpc.public_subnet_3
}

#Private Subnets ID
output "private_subnet_1" {
  value = module.module_vpc.private_subnet_1
}

output "private_subnet_2" {
  value = module.module_vpc.private_subnet_2
}

#Security Group ID - web
output "web_security_group_id" {
  value = module.module_vpc.web_security_group_id
}

#Security Group ID - RDS
output "rds_security_group_id" {
  value = module.module_vpc.rds_security_group_id
}

# #################### EC2 ####################
# output "public_ec2_instance_ids" {
#   value = module.module_ec2.pub_ec2_inst_ids
# }

# # output "private_ec2_instance_ids" {
# #   value = module.module_ec2.pvt_ec2_inst_ids
# # }

# output "public_ip" {
#   value = module.module_ec2.public_ip_addresses
# }

# #################### S3 ####################
# output "aws_s3_bucket_name" {
#   value = module.module_s3.aws_s3_bucket
# }

# #################### ALB ####################

# output "aws_lb_id" {
#   value = module.module_alb.aws_lb_id
# }

# output "Launch_template_id" {
#   value = module.module_alb.template_id
# }

#################### ALB ####################
# output "db_instance" {
#   value = 
# }
