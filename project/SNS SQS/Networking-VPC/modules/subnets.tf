#subnet creation in blue VPC
resource "aws_subnet" "blue" {
  depends_on              = [aws_vpc.blue]
  vpc_id                  = aws_vpc.blue.id
  cidr_block              = var.blue_subnet_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = var.blue_subnet_az
  tags = {
    Name = "${var.blue_vpc}-subnet"
  }
}