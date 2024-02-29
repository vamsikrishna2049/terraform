# Create a subnet within the VPC
resource "aws_subnet" "pub-sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.vpc_name}-pub-sn"
  }
}

# # aws_subnet.PUB-SN will be created
#   + resource "aws_subnet" "PUB-SN" {
#       + arn                                            = (known after apply)
#       + assign_ipv6_address_on_creation                = false
#       + availability_zone                              = "us-east-1a"
#       + availability_zone_id                           = (known after apply)
#       + cidr_block                                     = "10.0.1.0/24"
#       + enable_dns64                                   = false
#       + enable_resource_name_dns_a_record_on_launch    = false
#       + enable_resource_name_dns_aaaa_record_on_launch = false
#       + id                                             = (known after apply)
#       + ipv6_cidr_block_association_id                 = (known after apply)
#       + ipv6_native                                    = false
#       + map_public_ip_on_launch                        = true
#       + owner_id                                       = (known after apply)
#       + private_dns_hostname_type_on_launch            = (known after apply)
#       + tags                                           = {
#           + "Name" = "{}-PUB-SN"
#         }
#       + tags_all                                       = {
#           + "Name" = "dev-PUB-SN"
#         }
#       + vpc_id                                         = (known after apply)
#     }