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

#Public Subnets - Webserver
output "WebServer_subnetId" {
  value = aws_subnet.WebServer.id
}

#Public Subnets -Baston Host
output "BastonHost_subnetId" {
  value = aws_subnet.BastonHost.id
}

#Private Subnets - App Sever
output "AppServer_subnetId" {
  value = aws_subnet.AppSever.id
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
