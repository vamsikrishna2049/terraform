# Create a subnet within the VPC
resource "aws_subnet" "PUB-SN" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "${var.vpc_name}-PUB-SN"
  }
}
