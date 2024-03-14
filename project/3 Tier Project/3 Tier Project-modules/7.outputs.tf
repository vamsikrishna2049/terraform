#################### VPC ####################
#VPC ID
output "vpc_id" {
  value = module.module_vpc.vpc_id
}

#Public Subnets ID - Web and Bastion Host
output "PublicSubnetID" {
  value = module.module_vpc.public_subnetId
}

#Private Subnets ID - App Server
output "private_subnetId1" {
  value = module.module_vpc.private_subnetId1
}

#Private Subnets ID - RDS1 Server
output "private_subnetId2" {
  value = module.module_vpc.private_subnetId2
}

#Private Subnets ID - RDS2 Server
output "private_subnetId3" {
  value = module.module_vpc.private_subnetId3
}

#IGW 
output "internet_gateway_id" {
  value = module.module_vpc.internet_gateway_id
}

#Security Group ID - Bastion Host
output "BastionHost-security_group" {
  value = module.module_vpc.BastionHostSGID
}

#Security Group ID -App SG
output "AppSG-security_group" {
  value = module.module_vpc.AppSGID
}

#Security Group ID -DBSG
output "DbSG-security_group" {
  value = module.module_vpc.DbSGID
}

#################### EC2 ####################
output "webServerId" {
  value = module.module_ec2.WebServerIds
}

output "BastionHostId" {
  value = module.module_ec2.BastionHostId
}

output "AppServerId" {
  value = module.module_ec2.AppServerIds
}

#################### RDS ####################
output "RDS" {
  value = module.module_rds.rds_instance_endpoint
}
