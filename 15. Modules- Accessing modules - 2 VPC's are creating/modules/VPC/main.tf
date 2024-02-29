# Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "${var.module_name}-vpc"
  }
}

# Creating - public subnets
resource "aws_subnet" "pub_sn" {
  count                   = var.pub_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index * 2}.0/24"
  availability_zone       = element(var.pub_azs, count.index % length(var.pub_azs))
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.module_name}-pub-sn-${count.index + 1}"
  }
}

# Creating - Private Subnets
resource "aws_subnet" "pvt_sn" {
  count                   = var.pvt_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${(count.index * 2) + 1}.0/24"
  availability_zone       = element(var.pvt_azs, count.index % length(var.pvt_azs))
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.module_name}-pvt-sn-${count.index + 1}"
  }
}

#Creating - IGW
resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "${var.module_name}-igw"
  }
}

#Creating - Routing Tables -Public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.module_name}-pub-rt"
  }
}

#Creating - Routing Tables -Private
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.module_name}-pvt-rt"
  }
}

#Edit Subnet Associations - Public
resource "aws_route_table_association" "pub_sn_ass" {
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.pub_sn.*.id, count.index)
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations - Private
resource "aws_route_table_association" "pvt_sn_ass" {
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.pvt_sn.*.id, count.index)
  route_table_id = aws_route_table.pvt.id
}


######################## Creating - Security Groups ########################
resource "aws_security_group" "TF_SG" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.module_name}-sg_name"
  description = "Created by using TerraForm"
  #Edit inbound rules
  ingress {
    description = "Allow In-Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1 # All
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Edit outbound rules
  egress {
    description = "Allow OUt Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.module_name}-sg"
  }
}
