# #Creating Touting Table
# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = {
#     Name = "TF-RT"
#   }
# }

# resource "aws_route_table_association" "RED-PUB-SN-1A" {
#   subnet_id      = aws_subnet.pub-sn.id
#   route_table_id = aws_route_table.rt.id
# }

# output "aws_route_table" {
#   value = aws_route_table.rt.id
# }


# #Reference:
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
