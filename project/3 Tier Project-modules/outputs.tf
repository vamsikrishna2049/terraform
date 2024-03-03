#################### VPC ####################
#VPC ID
output "vpc_id" {
  value = module.module_vpc.vpc_id
}

#Public Subnets ID
output "WebServerSubnetID" {
  value = module.module_vpc.web_sn_cidr
}

output "BastonServerSubnetID" {
  value = module.module_vpc.baston_sn_cidr
}

output "AppServerSubnetID" {
  value = module.module_vpc.app_sn_cidr
}

output "RDSServerSubnetID_AZ-A" {
  value = module.module_vpc.rds1_sn_cidr
}

output "RDSServerSubnetID_AZ-B" {
  value = module.module_vpc.rds2_sn_cidr
}

#Security Group ID
output "security_group" {
  value = module.module_vpc.security_group_id
}

#################### EC2 ####################
output "public_ec2_instance_ids" {
  value = module.module_ec2.pub_ec2_inst_ids
}

# output "private_ec2_instance_ids" {
#   value = module.module_ec2.pvt_ec2_inst_ids
# }

output "public_ip" {
  value = module.module_ec2.public_ip_addresses
}
