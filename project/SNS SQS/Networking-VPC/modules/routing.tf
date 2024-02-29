#route tables - blue
resource "aws_route_table" "blue" {
  vpc_id = aws_vpc.blue.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.blue.id
  }

  tags = {
    Name = "${var.blue_vpc}-blue-rt"
  }
}

#Edit subnet associations blue-Subnet
resource "aws_route_table_association" "blue_sn_ass" {
  subnet_id      = aws_subnet.blue.id
  route_table_id = aws_route_table.blue.id
}

# creating Security Groups
resource "aws_security_group" "blue_TF_SG" {
  vpc_id = aws_vpc.blue.id
  name   = "${var.blue_vpc}-sg_name"
  #description = "Created by using TF Code"
  #Edit inbound rules
  # Choose only one ingress rule 

  # Allow Only SSH port
  ingress {
    #description = "Blue VPC Allow In-Bound Traffic"
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
    Name = "${var.blue_vpc}-sg"
  }
}
