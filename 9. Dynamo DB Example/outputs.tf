output "aws_vpc" {
  value = aws_vpc.main.id
}

output "aws_subnet" {
  value = aws_subnet.pub_sub.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.main.id
}

output "aws_route_table" {
  value = aws_route_table.rt-main.id
}

output "sgroup" {
  value = aws_security_group.SG.id
}

