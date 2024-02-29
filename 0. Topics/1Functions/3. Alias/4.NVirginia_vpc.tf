#VPC Creation
resource "aws_vpc" "Nvirg_vpc" {
  provider             = aws.Nvirg
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

#public subnets Creation
resource "aws_subnet" "nvir_pub_sub" {
  provider   = aws.Nvirg
  count      = length(var.pub_subnet_count)
  vpc_id     = aws_vpc.Nvirg_vpc.id
  cidr_block = element(var.pub_subnet_cidr_block, count.index)
  # availability_zone       = element(var.azs, count.index)
  availability_zone       = element(lookup(var.azs, "us-east-1"), count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn-${count.index + 1}"
  }
}

#private subnets Creation
resource "aws_subnet" "nvir_pvt_sub" {
  provider   = aws.Nvirg
  count      = var.pvt_subnet_count
  vpc_id     = aws_vpc.Nvirg_vpc.id
  cidr_block = element(var.pvt_subnet_cidr_block, count.index)
  # availability_zone       = element(var.azs, count.index)
  availability_zone       = element(lookup(var.azs, "us-east-1"), count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pvt-sn-${count.index + 1}"
  }
}

#IGW Gateway
resource "aws_internet_gateway" "Nvirg_igw" {
  provider = aws.Nvirg
  vpc_id   = aws_vpc.Nvirg_vpc.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
  depends_on = [aws_vpc.Nvirg_vpc]
}

#route tables - public
resource "aws_route_table" "pub" {
  provider = aws.Nvirg
  vpc_id   = aws_vpc.Nvirg_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Nvirg_igw.id
  }
  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}

# #Elastic IP
# resource "aws_eip" "Nvirg_eip" {
#   provider = aws.Nvirg
#   # instance = aws_instance.public-servers.0.id
#   tags = {
#     Name = "${var.vpc_name}-nat-eip"
#   }
# }

# # EIP Association  - You need to execute this block of code after creation of public server.
# resource "aws_eip_association" "Nvirg_vpc_eip_assoc" {
#   provider      = aws.Nvirg
#   count         = 1
#   allocation_id = aws_eip.Nvirg_eip.id
#   instance_id   = aws_instance.Nvirg-public-servers.0.id
# }

# #NAT Gateway
# resource "aws_nat_gateway" "Nvirg_nat" {
#   provider      = aws.Nvirg
#   allocation_id = aws_eip.Nvirg_eip.id
#   subnet_id     = aws_subnet.nvir_pub_sub.0.id
#   # depends_on    = [aws_internet_gateway.igw]
#   tags = {
#     Name = "${var.vpc_name}-nat_gateway"
#   }
# }

#route tables - private
resource "aws_route_table" "Nvirg_vpc_pvt" {
  provider = aws.Nvirg
  vpc_id   = aws_vpc.Nvirg_vpc.id
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.Nvirg_nat.id
  # }
  tags = {
    Name = "${var.vpc_name}-pvt-rt"
  }
}

#Edit subnet associations for pub-sn
resource "aws_route_table_association" "Nvirg_pub_sn_ass" {
  provider       = aws.Nvirg
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.nvir_pub_sub.*.id, count.index) #aws_subnet.us-east-1.*.id Terraform splat syntax
  route_table_id = aws_route_table.pub.id

}

#Edit subnet associations for pvt-sn
resource "aws_route_table_association" "Nvirg_pvt_sn_ass" {
  provider       = aws.Nvirg
  count          = var.pvt_subnet_count
  subnet_id      = element(aws_subnet.nvir_pvt_sub.*.id, count.index)
  route_table_id = aws_route_table.Nvirg_vpc_pvt.id
}

# creating Security Groups
resource "aws_security_group" "Nvirg_sg" {
  provider    = aws.Nvirg
  vpc_id      = aws_vpc.Nvirg_vpc.id
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
