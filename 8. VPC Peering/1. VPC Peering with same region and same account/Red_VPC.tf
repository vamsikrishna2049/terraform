#red VPC Creation
resource "aws_vpc" "red" {
  cidr_block           = var.red_vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.red_vpc}-vpc"
  }
}

#subnet creation in red VPC
resource "aws_subnet" "red" {
  count                   = var.red_subnet_count
  depends_on              = [aws_vpc.red]
  vpc_id                  = aws_vpc.red.id
  cidr_block              = element(var.red_subnet_cidr_block, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.red_subnet_az, count.index)
  tags = {
    Name = "${var.red_vpc}-subnet"
  }
}

#Internet gateway
resource "aws_internet_gateway" "red" {
  depends_on = [aws_subnet.red]
  vpc_id     = aws_vpc.red.id
  tags = {
    Name = "${var.red_vpc}-igw"
  }
}

#route tables - red
resource "aws_route_table" "red" {
  vpc_id = aws_vpc.red.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.red.id
  }

  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = aws_vpc_peering_connection.red_to_white.id
  }

  tags = {
    Name = "${var.red_vpc}-red-rt"
  }
}

#Edit subnet associations red-Subnet
resource "aws_route_table_association" "red_sn_ass" {
  count          = var.red_subnet_count
  subnet_id      = element(aws_subnet.red.*.id, count.index)
  route_table_id = aws_route_table.red.id
}

# creating Security Groups
resource "aws_security_group" "red_TF_SG" {
  vpc_id      = aws_vpc.red.id
  name        = "${var.red_vpc}-sg_name"
  description = "Created by using TF"
  #Edit inbound rules
  ingress {
    description = "Red VPC Allow In-Bound Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
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
    Name = "${var.red_vpc}-sg"
  }
}

# Note:
# Allow All Traffic 
#   ingress {
#     #description = "Blue VPC Allow In-Bound Traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = -1 # All
#     cidr_blocks = ["0.0.0.0/0"]
#   }
