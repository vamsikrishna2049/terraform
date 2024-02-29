#After infra created by Terraform over cloud platform
output "aws_vpc" {
  value = aws_vpc.main.id
}
output "aws_pub_subnet" {
  value = aws_subnet.pub_sn.*.id
}
output "aws_pvt_subnet" {
  value = aws_subnet.pvt_sn.*.id
}
output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}
output "aws_route_table_association" {
  value = aws_route_table_association.pub_sn_ass
}