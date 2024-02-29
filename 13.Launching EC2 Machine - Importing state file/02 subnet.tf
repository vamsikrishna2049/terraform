# Create a subnet within the VPC
resource "aws_subnet" "pub-sn" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.1.1.0/24"
  #enable_dns_hostnames = true
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "TF-PUB-SN"
  }
}

output "aws_subnet" {
  value = aws_subnet.pub-sn.id
}

# Reference: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet
