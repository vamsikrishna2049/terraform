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
  subnet_id      = element(aws_subnet.pub_sn.*.id, count.index) #aws_subnet.pub_sn.*.id Terraform splat syntax
  route_table_id = aws_route_table.pub.id

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

# Launch Web Servers
resource "aws_instance" "web" {
  count                       = var.instance_count
  subnet_id                   = element(aws_subnet.pub_sn.*.id, count.index)
  associate_public_ip_address = true
  ami                         = var.ami_id        # Replace with your desired AMI (Amazon Linux, etc.)
  instance_type               = var.instance_type # Instance Size
  key_name                    = var.key_name      # Replace with your key pair name

  security_groups = [aws_security_group.web_sg.id]


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",          # Update package repositories (for Amazon Linux)
      "sudo yum install -y nginx",   # Install Nginx
      "sudo systemctl enable nginx", # Enable Nginx to start on boot
      "sudo systemctl start nginx"   # Start Nginx
    ]
  }

  provisioner "file" {
    source      = "./index.html"                          # Path to your local index.html file
    destination = "sudo /usr/share/nginx/html/index.html" # Destination path on the EC2 instance
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"            # Default user name
    private_key = file("./keypair.pem") # Adjust the path to your SSH private key
    host        = self.public_ip        # Use self.public_ip to access the public IP of each instance
  }

  tags = {
    Name = "${var.vpc_name}-web-${count.index + 1}"
  }
}
