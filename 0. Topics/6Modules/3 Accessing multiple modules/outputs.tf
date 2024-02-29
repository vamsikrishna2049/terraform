#################### VPC ####################
#VPC ID
output "vpc_id" {
  value = module.module_vpc.VPCID
}

#Public Subnets ID
output "public_subnet_ids" {
  value = module.module_vpc.public_subnets
}

#Private Subnets ID
output "private_subnet_ids" {
  value = module.module_vpc.private_subnets
}

#IGW ID
output "igw_id" {
  value = module.module_vpc.internet_gateway_id
}

#Security Group ID
output "security_group" {
  value = module.module_vpc.security_group_id
}

#Routing Tables-Public
output "pub_routing_table" {
  value = module.module_vpc.public_routing_table
}

#Routing Tables-Private
output "pvt_routing_table" {
  value = module.module_vpc.private_routing_table
}

#################### EC2 ####################
output "public_ec2_instance_ids" {
  value = module.module_ec2.pub_ec2_inst_ids
}

# output "private_ec2_instance_ids" {
#   value = module.module_ec2.pvt_ec2_inst_ids
# }
