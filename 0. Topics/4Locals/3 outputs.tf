output "aws_vpc" {
  value = aws_vpc.main.id
}

output "aws_subnet" {
  value = aws_subnet.PUB-SN.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}
