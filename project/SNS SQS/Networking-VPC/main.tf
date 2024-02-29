#blue VPC Creation
resource "aws_vpc" "blue" {
  cidr_block           = var.blue_vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.blue_vpc
  }
}



#Internet gateway
resource "aws_internet_gateway" "blue" {
  depends_on = [aws_subnet.blue]
  vpc_id     = aws_vpc.blue.id
  tags = {
    Name = "${var.blue_vpc}-igw"
  }
}

