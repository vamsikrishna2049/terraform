# Create a subnet within the VPC 
resource "aws_subnet" "pub-sn1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "TF-PUB-SN1"
  }
}

resource "aws_subnet" "pub-sn2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "TF-PUB-SN2"
  }
}

output "PublicSubnet1" {
  value = aws_subnet.pub-sn1.id
}

# Reference: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet
