# Creating the VPC peering connection from red-vpc to white-vpc
resource "aws_vpc_peering_connection" "red_to_white" {
  peer_vpc_id = aws_vpc.white.id
  vpc_id      = aws_vpc.red.id
  peer_region = "us-west-2"
  tags = {
    "Name" = "Red to White VPC Peering"
  }
}

# Creating the VPC peering connection from white-vpc to red-vpc
resource "aws_vpc_peering_connection_accepter" "white_to_red" {
  auto_accept               = true
  vpc_peering_connection_id = aws_vpc_peering_connection.red_to_white.id
  tags = {
    "Name" = "White to Red VPC Peering"
  }
}
