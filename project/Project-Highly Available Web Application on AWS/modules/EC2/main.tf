# Define the EC2 instance in public subnet's
resource "aws_instance" "public_subnet" {
  # count                  = var.pub_instance_count
  count         = var.environment == "production" ? 3 : 1
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "vockey"
  # subnet_id   = element(module.vpc.public_subnets, 0)
  subnet_id = element(var.public_subnets, count.index)
  # vpc_security_group_ids = [module.vpc.security_group_id]
  vpc_security_group_ids      = [var.sg_name]
  associate_public_ip_address = "true"

  tags = {
    Name = "${var.prefix}-pub-sn-${count.index + 1}"
  }
  user_data = file("${path.module}/script.sh")
}

#Define the EC2 instance in private subnet's
# resource "aws_instance" "private_subnet" {
#   count                  = var.environment == "production" ? 3 : 1
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   key_name               = "vockey"
#   subnet_id              = element(var.private_subnets,count.index)
#   vpc_security_group_ids = [var.sg_name]
#   associate_public_ip_address = "false"
#   tags = {
#     Name = "${var.prefix}-pvt-sn-${count.index + 1}"
#   }
# }

resource "aws_instance" "private_subnet" {
  count                       = var.environment == "production" ? 3 : 1
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey"
  subnet_id                   = element(var.private_subnets, count.index)
  vpc_security_group_ids      = [var.sg_name]
  associate_public_ip_address = false
  tags = {
    Name = "${var.prefix}-pvt-sn-${count.index + 1}"
  }

  #   user_data = <<-EOF
  #   #!/bin/bash
  #   sudo yum update -y
  #   sudo yum install httpd -y 
  #   sudo systemctl start httpd 
  #   sudo systemctl enable httpd
  #   sudo echo "<h1>Deployed via Terraform on ${var.prefix}-pvt-${count.index + 1}</h1>" | sudo tee /var/www/html/index.html
  #   EOF
}

