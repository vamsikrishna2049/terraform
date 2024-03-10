#Provisioning the Web Server(EC2 instance) in Public subnet - Web Security Group
resource "aws_instance" "WebServer" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" # It was already created via management console. If you can also create by defining a key pair module.
  subnet_id                   = aws_subnet.pub_sn.id
  vpc_security_group_ids      = [aws_security_group.WebSG.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.prefix}-WebServer" # Unique names for each instance
  }
  user_data = file("${path.module}/script-web.sh")
}

#Provisioning the Baston Host(EC2 instance) in Public subnet - Baston Host Security Group
resource "aws_instance" "BastonHost" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" #It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = aws_subnet.pub_sn.id
  vpc_security_group_ids      = [aws_security_group.BastionHostSG.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.prefix}-BastonHost" # Unique names for each instance
  }
}

resource "aws_instance" "AppServer" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" # It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = aws_subnet.pvt_sn1.id
  vpc_security_group_ids      = [aws_security_group.AppSG.id]
  associate_public_ip_address = false

  tags = {
    Name = "${var.prefix}-AppServer" # Unique names for each instance
  }
  # User data script to provision the App server based on the Linux distribution
  user_data = file("${path.module}/script-app.sh")
}

