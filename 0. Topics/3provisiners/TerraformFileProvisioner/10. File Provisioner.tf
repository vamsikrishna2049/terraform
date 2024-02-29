# # File Provisioner
# # As the name suggests file provisioner can be used for transferring and copying the files from one machine to another machine.
# # Not only file but it can also be used for transferring/uploading the directories.
# # So when we talk about copying files or directories from one machine to another machine then it has to be secured and file provisioner supports for ssh and winrm type of connections which can help you to achieve secure file transfer between the source machine and destination machine.

# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "PUB-SN" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_range
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.vpc_name}-PUB-SN"
  }
}

#Create IGW and Connect to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

# Creating Security Group
resource "aws_security_group" "TF_SG" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.vpc_name}-sg_name"
  description = "Created by using TF"

  ingress {
    description = "Allow In-Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-sg"
  }
}

# Creating a key pair for EC2 Instance
resource "aws_key_pair" "main" {
  key_name   = "TFCode"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOdNpkBe9+W5d3SlZT5N0PgzbuWpKCVxrg4smPmvZNWVYSk+xejefPrh+/zB8fY6ly4FnhrqEHJJWvLErf/94Vqn3oMHvnw5iOVZ6BJysIN1geSpAmvOMB4HoT9Aw004EiqtuOuuenCzOgnI8dYM4u+d0zoGmxzvJZ2OtcaQ18kJr9WfNvlLc48q0Ly1UsUVhyG5WSVqLcQe+qfrex8+p9lzLFWrmz/ICRDHwN3RON+uesJ7LIs5ZfCc7+7Pjr/4kR5sdJOozQUOXNU4kGL6j7kaBEPnTPDn16mMIbxQk55g9cyP4KZmKYcAJFF97BcOD57P4mSY8zPr7/v+l3Rrh/ krishnap201997@gmail.com"
}

# Define the EC2 instance
resource "aws_instance" "ubuntu" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.PUB-SN.id
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name               = aws_key_pair.main.id
  tags = {
    Name = "ubuntuMachine"
  }
  provisioner "file" {
    source      = "D:/Work Space/Cloud/AWS/Terraform/EX-7 Terraform Provisioner/readme.txt"
    destination = "/home/ubuntu/fromwindows.txt"
  }
  # connection {
  #   type        = "ssh"
  #   host        = self.public_ip
  #   user        = "ubuntu"
  #   private_key = file("/home/rahul/Jhooq/keys/aws/aws_key")
  #   timeout     = "4m"
  # }
}

