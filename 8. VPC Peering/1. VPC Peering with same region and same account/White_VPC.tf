#White VPC Creation
resource "aws_vpc" "white" {
  cidr_block           = var.white_vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.white_vpc
  }
}

#subnet creation in White VPC
resource "aws_subnet" "white" {
  depends_on              = [aws_vpc.white]
  vpc_id                  = aws_vpc.white.id
  cidr_block              = var.white_subnet_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = var.white_subnet_az
  tags = {
    Name = "${var.white_vpc}-subnet"
  }
}

#Internet gateway
resource "aws_internet_gateway" "white" {
  depends_on = [aws_subnet.white]
  vpc_id     = aws_vpc.white.id
  tags = {
    Name = "${var.white_vpc}-igw"
  }
}

#route tables - white
resource "aws_route_table" "white" {
  vpc_id = aws_vpc.white.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.white.id
  }

  tags = {
    Name = "${var.white_vpc}-white-rt"
  }
}

#Edit subnet associations White-Subnet
resource "aws_route_table_association" "white_sn_ass" {
  subnet_id      = aws_subnet.white.id
  route_table_id = aws_route_table.white.id
}

# creating Security Groups
resource "aws_security_group" "white_TF_SG" {
  vpc_id      = aws_vpc.white.id
  name        = "${var.white_vpc}-sg_name"
  description = "Created by using TF"
  #Edit inbound rules
  ingress {
    description = "white VPC Allow In-Bound Traffic"
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
    Name = "${var.white_vpc}-sg"
  }
}


#Note:
#Allow All Traffic 
# ingress {
#   #description = "Blue VPC Allow In-Bound Traffic"
#   from_port   = 0
#   to_port     = 0
#   protocol    = -1 # All
#   cidr_blocks = ["0.0.0.0/0"]
# }

#Allow All TCP Traffic
# ingress {
#   #description = "Blue VPC Allow In-Bound TCP Traffic"
#   from_port   = 0
#   to_port     = 65535 # All TCP ports
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
