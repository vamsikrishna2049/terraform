# This output block helps you to retrieve the values from individual module to outside 
#VPC ID
output "vpc_id" {
  value = module.module_vpc.VPCID
}

#Public Subnets ID
output "public_subnet_ids" {
  value = module.module_vpc.public_subnets
}

# Public CIDR Range
output "public_subnets_CIDR" {
  value = module.module_vpc.public_subnets_CIDR
}

#Private Subnets ID
output "private_subnet_ids" {
  value = module.module_vpc.private_subnets
}

# Private CIDR Range
output "private_subnets_CIDR" {
  value = module.module_vpc.private_subnets_CIDR
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
