# #once infrastructure created by Terraform - we will get the values. 
# output "aws_vpc" {
#   value = aws_vpc.main.id
# }
# output "aws_pub_subnet" {
#   value = aws_subnet.pub_sn.*.id
# }
# output "aws_pvt_subnet" {
#   value = aws_subnet.pvt_sn.*.id
# }
# output "aws_internet_gateway" {
#   value = aws_internet_gateway.igw.id
# }
# output "aws_route_table_association" {
#   value = aws_route_table_association.pub_sn_ass
# }
# output "aws_route_table_association" {
#   value = aws_route_table_association.pvt_sn_ass
# }
# output "aws_security_group" {
#   value = aws_security_group.allow_all.id
# }
# output "public_servers" {
#   value = aws_instance.public-servers.*.id
# }
# output "private_servers" {
#   value = aws_instance.private_servers.*.id
# }
# output "ami_value" {
#   value = lookup(var.amis, var.region)
# }
