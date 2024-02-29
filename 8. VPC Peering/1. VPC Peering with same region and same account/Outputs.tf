#once infrastructure created by Terraform created ID's will printed here.
# #RED-VPC
# output "aws_red_vpc" {
#   value = aws_vpc.red.id
# }
# output "aws_red_subnet" {
#   value = aws_subnet.red.id
# }
# output "aws_red_igw" {
#   value = aws_internet_gateway.red.id
# }
# output "aws_red_rt_association" {
#   value = aws_route_table_association.red_sn_ass
# }

# #White
output "aws_white_vpc" {
  value = aws_vpc.white.id
}
output "aws_white_subnet" {
  value = aws_subnet.white.id
}
output "aws_white_igw" {
  value = aws_internet_gateway.white.id
}
output "aws_white_rt_association" {
  value = aws_route_table_association.white_sn_ass
}