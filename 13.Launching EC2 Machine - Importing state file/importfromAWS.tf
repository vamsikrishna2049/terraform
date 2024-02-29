# # Importing from AWS VPC
# resource "aws_vpc" "name" {
#   cidr_block           = "10.0.0.0/16"
#   instance_tenancy     = "default"
#   enable_dns_hostnames = true
#   tags = {
#     Name = "Testing-vpc"
#   }
# }
# # terraform import aws_vpc.<VPC-Name> <VPCID>
# # terraform import aws_vpc.name vpc-060062df20ff6fa51

# resource "aws_subnet" "Testing-pub-sn-1" {
#   vpc_id                  = "vpc-085dc601933ee048c"
#   availability_zone       = "us-east-1a"
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "Testing-pub-sn-1"
#   }
# }
# #terraform import aws_subnet.<Subnet Name> <SubnetID>
# #terraform import aws_subnet.Testing-pub-sn-1 subnet-0f109cf33507b0f81

# resource "aws_subnet" "Testing-pub-sn-2" {
#   vpc_id                  = "vpc-085dc601933ee048c"
#   availability_zone       = "us-east-1a"
#   cidr_block              = "10.0.2.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "Testing-pub-sn-2"
#   }
# }
# #terraform import aws_subnet.<Subnet Name> <SubnetID>
# #terraform import aws_subnet.Testing-pub-sn-2 subnet-006b8c259e19504e0


# # resource "aws_igw" "Testing-igw"{
# #   vpc_id     = aws_vpc.name.id
# #   tags = {
# #     Name = "Testing-igw"
# #   }
# # }