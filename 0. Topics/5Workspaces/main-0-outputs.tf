output "aws_vpc" {
  value = aws_vpc.main.id
}

output "aws_subnet" {
  value = aws_subnet.pub-sn.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

output "aws_route_table" {
  value = aws_route_table.rt-main.id
}

output "sgroup" {
  value = aws_security_group.sg.id
}
