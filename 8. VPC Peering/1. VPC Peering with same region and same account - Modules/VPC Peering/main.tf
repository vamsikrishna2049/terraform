# #Two VPC's connected in same region with same account. 
# # Creating the VPC peering connection from red-vpc to white-vpc
# resource "aws_vpc_peering_connection" "red_to_white" {
#   peer_vpc_id = aws_vpc.white_vpc.id
#   vpc_id      = aws_vpc.red_vpc.id
#   auto_accept = true
# }

# # Creating the VPC peering connection from white-vpc to red-vpc
# resource "aws_vpc_peering_connection" "white_to_red" {
#   peer_vpc_id = aws_vpc.red_vpc.id
#   vpc_id      = aws_vpc.white_vpc.id
#   auto_accept = true
# }
