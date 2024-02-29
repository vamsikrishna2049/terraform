# #VPC Creation
# resource "aws_vpc" "default" {
#   cidr_block           = var.vpc_cidr_block
#   enable_dns_hostnames = "true"
#   tags = {
#     Name = var.vpc_name
#   }
# }

# #public subnets Creation
# resource "aws_subnet" "pub_sn" {
#   count                   = var.pub_subnet_count
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = element(var.pub_subnet_cidr_block, count.index)
#   availability_zone       = element(var.azs, count.index)
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.vpc_name}-pub-sn-${count.index + 1}"
#   }
# }

# #private subnets Creation
# resource "aws_subnet" "pvt_sn" {
#   count                   = var.pvt_subnet_count
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = element(var.pvt_subnet_cidr_block, count.index)
#   availability_zone       = element(var.azs, count.index)
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.vpc_name}-pvt-sn-${count.index + 1 }"
#   }
# }

# #igw connection
# resource "aws_internet_gateway" "default" {
#   vpc_id = aws_vpc.default.id
#   tags = {
#     "Name" = "${var.vpc_name}-igw"
#   }
#   # depends_on = [ aws_vpc.default]
# }

# #route tables - public
# resource "aws_route_table" "pub" {
#   vpc_id = aws_vpc.default.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.default.id
#   }

#   tags = {
#     Name = "${var.vpc_name}-pub-rt"
#   }
# }
# #route tables - private
# resource "aws_route_table" "pvt" {
#   vpc_id = aws_vpc.default.id
#   tags = {
#     Name = "${var.vpc_name}-pvt-rt"
#   }
# }

# #Edit subnet associations for pub-sn
# resource "aws_route_table_association" "pub_sn_ass" {
#   count          = var.pub_subnet_count
#   subnet_id      = element(aws_subnet.pub_sn.*.id, count.index)
#   route_table_id = aws_route_table.pub.id

# }

# #Edit subnet associations for pvt-sn
# resource "aws_route_table_association" "pvt_sn_ass" {
#   count          = var.pvt_subnet_count
#   subnet_id      = element(aws_subnet.pvt_sn.*.id, count.index)
#   route_table_id = aws_route_table.pvt.id
# }

# # creating Security Groups
# resource "aws_security_group" "TF_SG" {
#   vpc_id      = aws_vpc.default.id
#   name        = "${var.vpc_name}-sg_name"
#   description = "Created by using TF"
#   #Edit inbound rules
#   ingress {
#     description = "Red VPC Allow In-Bound Traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = -1 # All
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   #Edit outbound rules
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "${var.vpc_name}-sg"
#   }
# }

# # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "default" {
#   key_name   = "TFCode"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOdNpkBe9+W5d3SlZT5N0PgzbuWpKCVxrg4smPmvZNWVYSk+xejefPrh+/zB8fY6ly4FnhrqEHJJWvLErf/94Vqn3oMHvnw5iOVZ6BJysIN1geSpAmvOMB4HoT9Aw004EiqtuOuuenCzOgnI8dYM4u+d0zoGmxzvJZ2OtcaQ18kJr9WfNvlLc48q0Ly1UsUVhyG5WSVqLcQe+qfrex8+p9lzLFWrmz/ICRDHwN3RON+uesJ7LIs5ZfCc7+7Pjr/4kR5sdJOozQUOXNU4kGL6j7kaBEPnTPDn16mMIbxQk55g9cyP4KZmKYcAJFF97BcOD57P4mSY8zPr7/v+l3Rrh/ krishnap201997@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# # Define the EC2 instance in public subnet's
# resource "aws_instance" "pub-ser" {
#   count                  = var.pub_subnet_count
#   ami                    = var.ami_id
#   instance_type          = "t2.micro"
#   key_name               = "TFCode"
#   subnet_id              = element(aws_subnet.pub_sn.*.id, count.index)
#   vpc_security_group_ids = ["${aws_security_group.TF_SG.id}"]
#   tags = {
#     Name = "TF-${count.index + 1}-Pub-Machine"

#   }
# }

# # Define the EC2 instance in private subnet's
# resource "aws_instance" "pvt-ser" {
#   count                  = var.pvt_subnet_count
#   ami                    = var.ami_id
#   instance_type          = "t2.micro"
#   key_name               = "TFCode"
#   subnet_id              = element(aws_subnet.pvt_sn.*.id, count.index)
#   vpc_security_group_ids = ["${aws_security_group.TF_SG.id}"]
#   tags = {
#     Name = "TF-${count.index + 1}-Pvt-Machine"
#   }
# }
