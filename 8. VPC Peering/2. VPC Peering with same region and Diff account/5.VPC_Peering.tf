# Peering Connection from red_vpc to white_vpc
resource "aws_vpc_peering_connection" "red_to_white" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.white.id
  vpc_id        = aws_vpc.red.id
  tags = {
    Name = "peering between red2white"
  }
}

# Accept the peering connection in white VPC
resource "aws_vpc_peering_connection_accepter" "white_to_red_accepter" {
  provider                  = aws.Acceptor
  vpc_peering_connection_id = aws_vpc_peering_connection.red_to_white.id
  auto_accept               = "true"
}

# Modify routes to allow communication between peered VPCs
resource "aws_route" "red_to_white_route" {
  route_table_id            = aws_route_table.red.id
  destination_cidr_block    = aws_vpc.white.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.red_to_white.id
}

resource "aws_route" "white_to_red_route" {
  provider                  = aws.Acceptor
  route_table_id            = aws_route_table.white.id
  destination_cidr_block    = aws_vpc.red.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.red_to_white.id
}
