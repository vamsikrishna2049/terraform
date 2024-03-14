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

#Web - Security Groups
output "web_security_group_id" {
  value = aws_security_group.WebSG.id
}

#Data Base - Security Groups
output "rds_security_group_id" {
  value = aws_security_group.DbSG.id
}
