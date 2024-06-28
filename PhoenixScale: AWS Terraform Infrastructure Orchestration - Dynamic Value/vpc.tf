# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

# It will retrieve availability zones in the specified region
data "aws_availability_zones" "available" {}

# Create a mapping between availability zones and numerical values
locals {
  azs = zipmap(data.aws_availability_zones.available.names, range(length(data.aws_availability_zones.available.names)))
}

# Creating Public Subnet
resource "aws_subnet" "pub_sn" {
  for_each                = local.azs
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value + 1)
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn-${each.value + 1}"
  }
}

# Creating Private Subnet
resource "aws_subnet" "pvt_sn" {
  for_each                = local.azs
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, each.value + 11)
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pvt-sn-${each.value + 1}"
  }
}

# IGW Creation
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
  depends_on = [aws_vpc.main]
}

# RouteTables - Public
resource "aws_route_table" "pub_sn" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}

# RouteTables - Private
resource "aws_route_table" "pvt_sn" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-pvt-rt"
  }
}

# SubnetAssociations - Public
resource "aws_route_table_association" "pub_sn_ass" {
  for_each       = local.azs
  subnet_id      = aws_subnet.pub_sn[each.key].id
  route_table_id = aws_route_table.pub_sn.id
}

# SubnetAssociations - Private
resource "aws_route_table_association" "pvt_sn_ass" {
  for_each       = local.azs
  subnet_id      = aws_subnet.pvt_sn[each.key].id
  route_table_id = aws_route_table.pvt_sn.id
}

#SecurityGroupWebServers
resource "aws_security_group" "web_sg" {
  description = "Security group for web servers"
  name        = "Web Security Group"
  vpc_id      = aws_vpc.main.id
  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      from_port = ingress.value["from_port"]
      to_port   = ingress.value["to_port"]
      protocol  = ingress.value["protocol"]

      cidr_blocks = can(ingress.value["cidr"]) ? (
        length([for x in ingress.value["cidr"] : x if can(x)]) > 0 ? ingress.value["cidr"] : []
      ) : []
    }
  }
  #Edit outbound rules
  egress {
    description = "Out-bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "WebServer SecurityGroup"
  }
}



# NAT Gateway need to write it
