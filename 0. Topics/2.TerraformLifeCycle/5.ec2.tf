# # Creating a key pair for EC2 Instance - create the new public key and use it.
# resource "aws_key_pair" "default" { 
#   key_name   = "TFCode"
#   public_key = "ssh-rsa G/cb2TuHm+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

#Note:
# you can skip creating keypair, if any key pair is avaialble in your cloud account. else create a keypair and mention the name.

#Public Subnet
resource "aws_instance" "public-servers" {
  count = var.pub_subnet_count # Specific no of instances will deploy
  #count                       = length(var.pub_subnet_cidr_block) # launch servers as per No of public subnet cidr blocks available
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.key_name == "Laptop" ? 1 : 0
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.pub_sub.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-pub-${count.index + 1}"
  }
  lifecycle {
    create_before_destroy = "true" # First it will create the new ec2 machine then delete the old machine.
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install -y nginx
  sudo echo "<h1>Deployed via Terraform on ${var.vpc_name}-pub-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
  EOF
}

#Private Subnet
resource "aws_instance" "private-servers" {
  count                  = var.pvt_subnet_count #length(var.pvt_subnet_cidr_block)
  ami                    = lookup(var.amis, var.region)
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(aws_subnet.pvt_sub.*.id, count.index)
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  tags = {
    Name = "${var.vpc_name}-pvt-${count.index + 1}"
  }
}
