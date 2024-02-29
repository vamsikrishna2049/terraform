#VPC Creation
resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "PUB-SN" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.vpc_name}-PUB-SN"
  }
}

#Create IGW and Connect to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

resource "aws_instance" "default" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform EC2"
  }
}

#String
variable "instance_type" {
  description = "Instance type t2.micro"
  type        = string
  default     = "t2.micro"
}

# For defining variable block you need
# description : Small or short description about the purpose of the variable
# type : What type of variable it is going to be ex - string, bool, number ...
# default : What would be the default value of the variable
