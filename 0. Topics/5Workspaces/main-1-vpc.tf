#VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

#  # aws_vpc.main will be created
#   + resource "aws_vpc" "main" {
#       + arn                                  = (known after apply)
#       + cidr_block                           = "10.0.0.0/16"
#       + default_network_acl_id               = (known after apply)
#       + default_route_table_id               = (known after apply)
#       + default_security_group_id            = (known after apply)
#       + dhcp_options_id                      = (known after apply)
#       + enable_classiclink                   = (known after apply)
#       + enable_classiclink_dns_support       = (known after apply)
#       + enable_dns_hostnames                 = true
#       + enable_dns_support                   = true
#       + enable_network_address_usage_metrics = (known after apply)
#       + id                                   = (known after apply)
#       + instance_tenancy                     = "default"
#       + ipv6_association_id                  = (known after apply)
#       + ipv6_cidr_block                      = (known after apply)
#       + ipv6_cidr_block_network_border_group = (known after apply)
#       + main_route_table_id                  = (known after apply)
#       + owner_id                             = (known after apply)
#       + tags                                 = {
#           + "Name" = "dev-vpc"
#         }
#       + tags_all                             = {
#           + "Name" = "dev-vpc"
#         }
#     }