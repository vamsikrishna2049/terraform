#locals
locals {
  staging_env = "Dev"
}

#VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "pub-sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${local.staging_env}-pub-subnet"
  }
}

# Create a private subnet within the VPC
resource "aws_subnet" "pvt-sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "${local.staging_env}-pub-subnet"
  }
}

#Create IGW and Connect to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.staging_env}-igw"
  }
}