#VPC Creation
resource "aws_vpc" "ohio" {
  provider             = aws.ohio
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

#public subnets Creation
resource "aws_subnet" "pub_sn_ohio" {
  provider   = aws.ohio
  count      = var.pub_subnet_count
  vpc_id     = aws_vpc.ohio.id
  cidr_block = element(var.pub_subnet_cidr_block, count.index)
  # availability_zone       = element(var.azs, count.index)
  availability_zone       = element(lookup(var.azs, "us-east-2"), count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn-${count.index + 1}"
  }
}

#private subnets Creation
resource "aws_subnet" "pvt_sn_ohio" {
  provider   = aws.ohio
  count      = var.pvt_subnet_count
  vpc_id     = aws_vpc.ohio.id
  cidr_block = element(var.pvt_subnet_cidr_block, count.index)
  # availability_zone       = element(var.azs, count.index)
  availability_zone = element(lookup(var.azs, "us-east-2"), count.index)
  tags = {
    Name = "${var.vpc_name}-pvt-sn-${count.index + 1}"
  }
}

#IGW Gateway
resource "aws_internet_gateway" "ohio_igw" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
  depends_on = [aws_vpc.ohio]
}

#route tables - public
resource "aws_route_table" "ohio_pub" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ohio_igw.id
  }
  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}

# #Elastic IP
# resource "aws_eip" "ohio_eip" {
#  provider = aws.ohio
#   # instance = aws_instance.ohio-public-servers.0.id
#   tags = {
#     Name = "${var.vpc_name}-nat-eip"
#   }
# }

# # EIP Association  - You need to execute this block of code after creation of public server.
# resource "aws_eip_association" "ohio_eip_assoc" {
#  provider = aws.ohio
#   count         = 1
#   allocation_id = aws_eip.ohio_eip.id
#   instance_id   = aws_instance.ohio-public-servers.0.id
# }

# #NAT Gateway
# resource "aws_nat_gateway" "ohio_nat" {
#  provider = aws.ohio
#   allocation_id = aws_eip.ohio_eip.id
#   subnet_id     = aws_subnet.pub_sn_ohio.0.id
#   # depends_on    = [aws_internet_gateway.igw]
#   tags = {
#     Name = "${var.vpc_name}-nat_gateway"
#   }
# }

#route tables - private
resource "aws_route_table" "ohio-pvt" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio.id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.ohio_nat.id
  # }
  tags = {
    Name = "${var.vpc_name}-pvt-rt"
  }
}

#Edit subnet associations for pub-sn
resource "aws_route_table_association" "pub_sn_ohio_ass" {
  provider       = aws.ohio
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.pub_sn_ohio.*.id, count.index) #aws_subnet.pub_sn_ohio.*.id Terraform splat syntax
  route_table_id = aws_route_table.ohio_pub.id

}

#Edit subnet associations for pvt-sn
resource "aws_route_table_association" "pvt_sn_ohio_ohio_ass" {
  provider       = aws.ohio
  count          = var.pvt_subnet_count
  subnet_id      = element(aws_subnet.pvt_sn_ohio.*.id, count.index)
  route_table_id = aws_route_table.ohio-pvt.id
}

# creating Security Groups
resource "aws_security_group" "ohio" {
  provider    = aws.ohio
  vpc_id      = aws_vpc.ohio.id
  name        = "${var.vpc_name}-sg_name"
  description = "Created by using TF"
  #Edit inbound rules
  ingress {
    description = "TF VPC Allow In-Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1 # All
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Edit outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vpc_name}-sg"
  }
}
