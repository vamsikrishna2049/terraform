# # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "TFCode" {
#   key_name   = "TFCode"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTlxrRoONTY8I49Ox7ZiUJ4tlZQ0yE8ZcB77k+B0Ut70Np+lckJfPOfQWayIKX1P7apk3EtR0eQ4opSUrYC/99SLf/M+o7dVKBh2zlwexszCxWk9zeWa2StWovHroVhdgEIjdH+UNDOhSYjCbX31UNnWTMxZ+YqZlYZ7olO5QklOHmxyilJcaBeDP+dCc6oeyaBW1afRxCXGrPdxNNBFiDUW7nzBj4xecxJxsEw6HW7PsKEyops4JVeL+l3w6GdkrNSMSeRXBTiKHJ8JqdShJxoqLYpw8fb6NV9g0GUarBsRHvw3ySWk545EZLANh5tSGZmFebegZAXXR3lKJDLHsf TFCode"
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
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.pub_sn.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-pub-${count.index + 1}"
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
  count                       = var.pvt_subnet_count #length(var.pvt_subnet_cidr_block)
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.pvt_sn.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-pvt-${count.index + 1}"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install -y nginx
  sudo echo "<h1>Deployed via Terraform on ${var.vpc_name}-pvt-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
  EOF
}
