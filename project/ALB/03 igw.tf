#Create IGW and Connect to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "TF-IGW"
  }
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

# Reference: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
