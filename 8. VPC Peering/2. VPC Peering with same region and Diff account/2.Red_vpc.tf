#red VPC Creation
resource "aws_vpc" "red" {
  provider             = aws.Reciever
  cidr_block           = var.red_vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.red_vpc
  }
}

#subnet creation in red VPC
resource "aws_subnet" "red" {
  provider                = aws.Reciever
  depends_on              = [aws_vpc.red]
  vpc_id                  = aws_vpc.red.id
  cidr_block              = var.red_subnet_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = var.red_subnet_az
  tags = {
    Name = "${var.red_vpc}-subnet"
  }
}

#Internet gateway
resource "aws_internet_gateway" "red" {
  provider   = aws.Reciever
  depends_on = [aws_subnet.red]
  vpc_id     = aws_vpc.red.id
  tags = {
    Name = "${var.red_vpc}-igw"
  }
}

#route tables - red
resource "aws_route_table" "red" {
  provider = aws.Reciever
  vpc_id   = aws_vpc.red.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.red.id
  }

  tags = {
    Name = "${var.red_vpc}-red-rt"
  }
}

#Edit subnet associations red-Subnet
resource "aws_route_table_association" "red_sn_ass" {
  provider       = aws.Reciever
  subnet_id      = aws_subnet.red.id
  route_table_id = aws_route_table.red.id
}

# creating Security Groups
resource "aws_security_group" "red_TF_SG" {
  provider    = aws.Reciever
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

#   Allow All TCP Traffic
#   ingress {
#     #description = "Blue VPC Allow In-Bound TCP Traffic"
#     from_port   = 0
#     to_port     = 65535 # All TCP ports
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
