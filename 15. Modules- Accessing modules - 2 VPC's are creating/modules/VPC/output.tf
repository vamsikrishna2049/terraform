#VPCID
output "VPCID" {
  value = aws_vpc.main.id
}

#VPC CIDR Block 
output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

#Public Subnet Count
output "pub_subnet_count" {
  value = var.pub_subnet_count
}

#Public Subnets
output "public_subnets" {
  value = aws_subnet.pub_sn.*.id
}

#Public Subnets -Availability zone
output "public_subnets_availability_zones" {
  value = var.pub_azs
}

#Private subnetcount
output "pvt_subnet_count" {
  value = var.pvt_subnet_count
}

#Private Subnets
output "private_subnets" {
  value = [for subnet in aws_subnet.pvt_sn : subnet.id]
}

#Public Subnets -Availability zone
output "private_subnets_availability_zones" {
  value = var.pvt_azs
}

#Internet Gateway
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

#Security Groups
output "security_group_id" {
  value = aws_security_group.TF_SG.id
}

#Routing Tables-Public
output "public_routing_table" {
  value = aws_route_table.pub.id
}

#Routing Tables-Private
output "private_routing_table" {
  value = aws_route_table.pvt.id
}

#Module Name
output "module_name" {
  value = var.module_name
}

