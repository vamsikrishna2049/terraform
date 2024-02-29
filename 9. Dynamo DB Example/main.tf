resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn"
  }
}

resource "aws_subnet" "pvt_sub" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.vpc_name}-pvt-sn"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    name = "${var.vpc_name}-igw"
  }
}

#Creating Touting Table
resource "aws_route_table" "rt-main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.vpc_name}-RT"
  }
}

resource "aws_route_table_association" "PUB-SN" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.rt-main.id
}

# Creating a Security Group
resource "aws_security_group" "SG" {
  vpc_id      = aws_vpc.main.id
  name        = "TF-SG"
  description = "TF-SG Allow inbound traffic"

  ingress {
    description = "VPC Allow In-Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1 # All
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-SG"
  }
}
