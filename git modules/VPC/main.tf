#VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

#public subnets Creation
resource "aws_subnet" "pub_sn" {
  count                   = var.pub_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.pub_subnet_cidr_block, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn-${count.index + 1}"
  }
}

#private subnets Creation
resource "aws_subnet" "pvt_sn" {
  count                   = var.pvt_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.pvt_subnet_cidr_block, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pvt-sn-${count.index + 1}"
  }
}

#igw connection
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
  depends_on = [aws_vpc.main]
}

#route tables - public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}
#route tables - private
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-pvt-rt"
  }
}

#Edit subnet associations for pub-sn
resource "aws_route_table_association" "pub_sn_ass" {
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.pub_sn.*.id, count.index)	#aws_subnet.pub_sn.*.id Terraform splat syntax
  route_table_id = aws_route_table.pub.id

}

#Edit subnet associations for pvt-sn
resource "aws_route_table_association" "pvt_sn_ass" {
  count          = var.pvt_subnet_count
  subnet_id      = element(aws_subnet.pvt_sn.*.id, count.index)
  route_table_id = aws_route_table.pvt.id
}

# creating Security Groups
resource "aws_security_group" "TF_SG" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.vpc_name}-sg_name"
  description = "Created by using TF"
  #Edit inbound rules
  ingress {
    description = "Red VPC Allow In-Bound Traffic"
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
