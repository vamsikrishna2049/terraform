#This output block will help you to access the below elements from this VPC module to another module. 
#VPCID
output "VPCID" {
  value = aws_vpc.main.id
}

#Public Subnets
output "public_subnets" {
  value = {
    for idx, subnet in aws_subnet.pub_sn : subnet.id => subnet.cidr_block
  }
}

#Private Subnets
output "private_subnets" {
  value = [for subnet in aws_subnet.pvt_sn : subnet.id]
}

#Private Subnets CIDR Range
output "private_subnets_CIDR" {
  value = aws_subnet.pvt_sn.*.cidr_block
}

#Internet Gateway
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
