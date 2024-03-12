#Provisioning the Web Server(EC2 instance) in Public subnet -Web Security Group
resource "aws_instance" "WebServer" {
  count                       = var.environment == "production" ? 4 : 2
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey"
  subnet_id                   = var.public_subnetID
  vpc_security_group_ids      = [var.WebSG]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/script-web.sh")

  tags = {
    Name = "${var.prefix}-webServer-${count.index + 1}" # Unique names for each instance
  }
}

#Provisioning the Baston Host Server(EC2 instance) in Public subnet -Bastion Host Security Group
resource "aws_instance" "BastionHost" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" #It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = var.public_subnetID
  vpc_security_group_ids      = [var.BastionHostSG]
  associate_public_ip_address = true
  tags = {
    Name = "${var.prefix}-BastonHost" # Unique names for each instance
  }
}

#Provisioning the App Server(EC2 instance) in Private subnet -App Security Group
resource "aws_instance" "AppServer" {
  count                       = var.environment == "production" ? 4 : 2
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey"
  subnet_id                   = var.private_subnetId1
  vpc_security_group_ids      = [var.AppSG]
  associate_public_ip_address = false
  user_data                   = file("${path.module}/script-web.sh")

  tags = {
    Name = "${var.prefix}-AppServer-${count.index + 1}" # Unique names for each instance
  }
}
