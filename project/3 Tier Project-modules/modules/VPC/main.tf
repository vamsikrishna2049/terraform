# Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# Creating - Public subnets AZ-1 for Web Server & Baston Host
resource "aws_subnet" "WebServer" {
  vpc_id                  = aws_vpc.main.id # Reference to the VPC ID
  cidr_block              = var.pub # CIDR block for the subnet
  availability_zone       = var.az_a        # Availability Zone
  map_public_ip_on_launch = true            # Map public IP on launch
  tags = {
    Name = "${var.prefix}-WebServer" # Tag for the subnet
  }
}

# Creating - Public subnets AZ-1 for Baston Host Server 
resource "aws_subnet" "BastonHost" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.baston_sn_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-BastonHost"
  }
}

# Creating - Private Subnet AZ-1 for App server
resource "aws_subnet" "AppServer" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.app_sn_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-AppServer"
  }
}

# Creating - Private Subnet AZ-1 for RDS Instance 
resource "aws_subnet" "RDS1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.rds1_sn_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-RDS-AZ1"
  }
}

# Creating - Private Subnet AZ-2 for RDS Instance 
resource "aws_subnet" "RDS2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.rds1_sn_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-RDS-AZ2"
  }
}

#Creating - IGW
resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

# Creating Elastic IP for NAT Gateway 1 - Read/Write Replica
resource "aws_eip" "eip1" {
  tags = {
    Name = "${var.prefix}-eip1"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.pub_sn1.id
  tags = {
    Name = "${var.prefix}-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

#Creating - Routing Tables -Public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-pub-rt"
  }
}

#Creating - Routing Tables -Private
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.prefix}-pvt-rt"
  }
}

#Edit Subnet Associations for Public Subnet-1
resource "aws_route_table_association" "pub_sn_ass1" {
  subnet_id      = aws_subnet.pub_sn1.id
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations for Public Subnet-2
resource "aws_route_table_association" "pub_sn_ass2" {
  subnet_id      = aws_subnet.pub_sn2.id
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations for Public Subnet-3
resource "aws_route_table_association" "pub_sn_ass3" {
  subnet_id      = aws_subnet.pub_sn3.id
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations for Private Subnet-1
resource "aws_route_table_association" "pvt_sn_ass1" {
  subnet_id      = aws_subnet.pvt_sn1.id
  route_table_id = aws_route_table.pvt.id
}

#Edit Subnet Associations for Private Subnet-2
resource "aws_route_table_association" "pvt_sn_ass2" {
  subnet_id      = aws_subnet.pvt_sn2.id
  route_table_id = aws_route_table.pvt.id
}

#Edit Subnet Associations for Private Subnet-3
resource "aws_route_table_association" "pvt_sn_ass3" {
  subnet_id      = aws_subnet.pvt_sn3.id
  route_table_id = aws_route_table.pvt.id
}

#Creating - Security Groups
resource "aws_security_group" "tf-sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}-sg_name"
  # description = "Created by using TerraForm"

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
    Name = "${var.prefix}-sg"
  }
}
