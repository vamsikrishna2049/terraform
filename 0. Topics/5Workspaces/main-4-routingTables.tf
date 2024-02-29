#Creating Touting Table
resource "aws_route_table" "rt-main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

resource "aws_route_table_association" "pub-sn" {
  subnet_id      = aws_subnet.pub-sn.id
  route_table_id = aws_route_table.rt-main.id
}

# # aws_route_table.RT-Main will be created
#   + resource "aws_route_table" "RT-Main" {
#       + arn              = (known after apply)
#       + id               = (known after apply)
#       + owner_id         = (known after apply)
#       + propagating_vgws = (known after apply)
#       + route            = [
#           + {
#               + carrier_gateway_id         = ""
#               + cidr_block                 = "0.0.0.0/0"
#               + core_network_arn           = ""
#               + destination_prefix_list_id = ""
#               + egress_only_gateway_id     = ""
#               + gateway_id                 = (known after apply)
#               + instance_id                = ""
#               + ipv6_cidr_block            = ""
#               + local_gateway_id           = ""
#               + nat_gateway_id             = ""
#               + network_interface_id       = ""
#               + transit_gateway_id         = ""
#               + vpc_endpoint_id            = ""
#               + vpc_peering_connection_id  = ""
#             },
#         ]
#       + tags             = {
#           + "Name" = "dev-RT"
#         }
#       + tags_all         = {
#           + "Name" = "dev-RT"
#         }
#       + vpc_id           = (known after apply)
#     }

# # aws_route_table_association.PUB-SN will be created
#   + resource "aws_route_table_association" "PUB-SN" {
#       + id             = (known after apply)
#       + route_table_id = (known after apply)
#       + subnet_id      = (known after apply)
#     }
