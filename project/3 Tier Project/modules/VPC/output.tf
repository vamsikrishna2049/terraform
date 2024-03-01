#Module Name
output "prefix" {
  value = var.prefix
}

#VPCID
output "vpc_id" {
  value = aws_vpc.main.id
}

#VPC CIDR Block 
output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

#Public Subnets
output "public_subnet_1" {
  value = aws_subnet.pub_sn1.id
}

#Public Subnets
output "public_subnet_2" {
  value = aws_subnet.pub_sn2.id
}

#Public Subnets
output "public_subnet_3" {
  value = aws_subnet.pub_sn3.id
}

#Private Subnets
output "private_subnet_1" {
  value = aws_subnet.pvt_sn1.id
}

#Private Subnets
output "private_subnet_2" {
  value = aws_subnet.pvt_sn2.id
}

output "private_subnet_3" {
  value = aws_subnet.pvt_sn3.id
}

#Internet Gateway
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

#Security Groups
output "security_group_id" {
  value = aws_security_group.tf-sg.id
}

#Routing Tables-Public
output "public_routing_table" {
  value = aws_route_table.pub.id
}

#Routing Tables-Private
output "private_routing_table" {
  value = aws_route_table.pvt.id
}
