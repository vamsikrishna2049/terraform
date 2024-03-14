#VPCID
output "vpc_id" {
  value = aws_vpc.main.id
}

#Public Subnets-1 
output "public_subnetId" {
  value = aws_subnet.pub_sn.id
}

#Private Subnet-1
output "private_subnetId1" {
  value = aws_subnet.pvt_sn1.id
}

#Private Subnet-2
output "private_subnetId2" {
  value = aws_subnet.pvt_sn2.id
}

#Private Subnet-3
output "private_subnetId3" {
  value = aws_subnet.pvt_sn3.id
}

#Internet Gateway
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

#Security Groups -Web SG
output "WebSG" {
  value = aws_security_group.WebSG.id
}

#Security Groups -Bastion Host SG
output "BastionHostSGID" {
  value = aws_security_group.BastionHostSG.id
}

#Security Groups-App SG
output "AppSGID" {
  value = aws_security_group.AppSG.id
}

#Security Groups -DB SG
output "DbSGID" {
  value = aws_security_group.DbSG.id
}
