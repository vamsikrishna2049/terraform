#VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

#PublicSubnetCreation
resource "aws_subnet" "pub_sn" {
  count                   = var.pub_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.pub_subnet_cidr_block, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-pub-sn-${count.index + 1}"
  }
}

#IGW Creation
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
  depends_on = [aws_vpc.main]
}

#RouteTables-Public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-pub-rt"
  }
}

#SubnetAssociations
resource "aws_route_table_association" "pub_sn_ass" {
  count          = var.pub_subnet_count
  subnet_id      = element(aws_subnet.pub_sn.*.id, count.index)	#aws_subnet.pub_sn.*.id Terraform splat syntax
  route_table_id = aws_route_table.pub.id

}

#SecurityGroupWebServers
resource "aws_security_group" "web_sg" {
  description = "Security group for web servers"
  name        = "Web Security Group"
  vpc_id = aws_vpc.main.id
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
