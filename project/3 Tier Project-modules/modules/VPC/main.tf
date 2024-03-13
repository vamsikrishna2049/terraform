# Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}_vpc"
  }
}

# Creating - Public subnets AZ-1 for Web Server & Baston Host
resource "aws_subnet" "pub_sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sn
  availability_zone       = var.az_a
  map_public_ip_on_launch = true # If it's a public subnet
  tags = {
    Name = "${var.prefix}_pub_sn"
  }
}

# Creating - Private subnets AZ-1 for App Server 
resource "aws_subnet" "pvt_sn1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pvt_sn1
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # If it's a private subnet
  tags = {
    Name = "${var.prefix}_pvt_sn-1"
  }
}

# Creating - Private subnets AZ-1 for RDS Server 
resource "aws_subnet" "pvt_sn2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pvt_sn2
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # If it's a private subnet
  tags = {
    Name = "${var.prefix}_pvt_sn-2"
  }
}

# Creating - Private subnets AZ-2 for RDS Server 
resource "aws_subnet" "pvt_sn3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pvt_sn3
  availability_zone       = var.az_b
  map_public_ip_on_launch = false # If it's a private subnet
  tags = {
    Name = "${var.prefix}_pvt_sn-3"
  }
}

#Creating - IGW
resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "${var.prefix}_igw"
  }
}

# Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  tags = {
    Name = "${var.prefix}_eip"
  }
}

#Creating NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_sn.id
  tags = {
    Name = "${var.prefix}_nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

#Creating - Routing Tables -Public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}_pub_rt"
  }
}

#Creating - Routing Tables -Private
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.prefix}_pvt_rt"
  }
}

#Edit Subnet Associations for Public Subnet
resource "aws_route_table_association" "pub_sn_ass" {
  subnet_id      = aws_subnet.pub_sn.id
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations for Private Subnet-1
resource "aws_route_table_association" "pvt_sn_ass1" {
  subnet_id      = aws_subnet.pvt_sn1.id
  route_table_id = aws_route_table.pvt.id
}

#Edit Subnet Associations for Private Subnet-2
resource "aws_route_table_association" "pvt_sn_ass2" {
  subnet_id      = aws_subnet.pvt_sn2.id
  route_table_id = aws_route_table.pvt.id
}

#Edit Subnet Associations for Private Subnet-3
resource "aws_route_table_association" "pvt_sn_ass3" {
  subnet_id      = aws_subnet.pvt_sn3.id
  route_table_id = aws_route_table.pvt.id
}

# Creating - Web Server Security Group
resource "aws_security_group" "WebSG" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}_web_sg"
  # description = "Created by using TerraForm"

  # Edit inbound rules
  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow traffic from App SG"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.AppSG.id]
  }

  ingress {
    description = "Works for Ping"
    from_port   = -1 # ICMP doesn't have ports, so use -1
    to_port     = -1 # ICMP doesn't have ports, so use -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP traffic from any source
  }

  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Edit outbound rules
  egress {
    description = "Allow all Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_web_sg"
  }
}

# Creating - Bastion Host Server Security Group
resource "aws_security_group" "BastionHostSG" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}_bastion_sg"
  # description = "Created by using TerraForm"

  # No need to allow HTTP and HTTPS for bastion host
  # Edit inbound rules
  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMPv4 Traffic"
    from_port   = -1 // ICMP has no ports, so set from_port and to_port to -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Edit outbound rules
  egress {
    description = "Allow all Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_bastion_sg"
  }
}

# Creating - App Server Security Group
resource "aws_security_group" "AppSG" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}_app_sg"
  # description = "Created by using TerraForm"

  ingress {
    description = "Works for Ping"
    from_port   = -1 # ICMP doesn't have ports, so use -1
    to_port     = -1 # ICMP doesn't have ports, so use -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP traffic from any source
  }

  ingress {
    description     = "Allow traffic from BastionHostSG"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.BastionHostSG.id]
  }

  # Edit outbound rules
  egress {
    description = "Allow all Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_app_sg"
  }
}

# Creating - Database Server Security Group
resource "aws_security_group" "DbSG" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}_database_sg"
  # description = "Created by using TerraForm"

  # Edit inbound rules to allow traffic from AppSG and BastionHostSG
  ingress {
    description     = "Allow traffic from AppSG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.AppSG.id]
  }

  ingress {
    description     = "Allow traffic from BastionHostSG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.BastionHostSG.id]
  }

  # Edit outbound rules
  egress {
    description = "Allow all Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_db_sg"
  }
}

#Allowing the traffic to Baston SG from App SG 
resource "aws_security_group_rule" "bastion_to_app" {
  security_group_id        = aws_security_group.BastionHostSG.id
  description              = "Allows traffic from App"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.AppSG.id
}

resource "aws_security_group_rule" "db_to_app" {
  security_group_id        = aws_security_group.AppSG.id
  description              = "Allows traffic from DbSG"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.DbSG.id
}

#Allowing the traffic to App SG from Web SG
resource "aws_security_group_rule" "app_to_web" {
  security_group_id        = aws_security_group.AppSG.id
  description              = "Allow traffic from Web SG"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.WebSG.id
}

#Allowing the traffic to Baston SG from Database SG 
resource "aws_security_group_rule" "database_to_bastion" {
  security_group_id        = aws_security_group.BastionHostSG.id
  description              = "Allows traffic from DbSG"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.DbSG.id
}

resource "null_resource" "security_group_dependency" {
  triggers = {
    bastion_to_app_sg_rul    = aws_security_group_rule.bastion_to_app.id
    database_to_bastion_rule = aws_security_group_rule.database_to_bastion.id
    app_to_web_rule          = aws_security_group_rule.app_to_web.id
    db_to_app_rule           = aws_security_group_rule.db_to_app.id
  }
}
