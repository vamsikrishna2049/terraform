#Provisioning the Web Server(EC2 instance) in Public subnet -Web Security Group
resource "aws_instance" "WebServer" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" #It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = aws_subnet.pub_sn.id
  vpc_security_group_ids      = [aws_security_group.WebSG.id]
  associate_public_ip_address = true

  # User data script to provision the web server based on the Linux distribution
  user_data = <<-EOF
              #!/bin/bash
              if [ -f /etc/os-release ]; then
                . /etc/os-release

                if [[ $NAME == *"Amazon Linux"* ]]; then
                  sudo yum update -y
                  sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                  sudo yum install -y httpd
                  sudo systemctl start httpd
                  sudo systemctl enable httpd
                  echo "<h1>This page is coming from Amazon Linux EC2 Server provisioned through Terraform.</h1>" > /var/www/html/index.html

                elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
                  sudo apt-get update
                  sudo apt-get install -y apache2
                  sudo systemctl start apache2
                  sudo systemctl enable apache2
                  echo "<h1>This page is coming from Ubuntu/Debian EC2 Server provisioned through Terraform.</h1>" > /var/www/html/index.html
                else
                  echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
                  exit 1
                fi
              else
                echo "Unable to determine Linux distribution."
                exit 1
              fi
              EOF

  tags = {
    Name = "${var.prefix}-WebServer" # Unique names for each instance
  }
}

#Provisioning the App Server(EC2 instance) in Public subnet - App Security Group
resource "aws_instance" "AppServer" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" #It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = aws_subnet.pvt_sn1.id
  vpc_security_group_ids      = [aws_security_group.DB2App.id]
  associate_public_ip_address = false
  # User data script to provision the App server based on the Linux distribution
  user_data = <<-EOF
              #!/bin/bash
              if [ -f /etc/os-release ]; then
                . /etc/os-release

                if [[ $NAME == *"Amazon Linux"* ]]; then
                  #!/bin/bash
                  sudo yum update -y
                  sudo yum install -y mariadb-server
                  sudo service mariadb start

                elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
                  sudo apt-get update -y 
                  sudo apt-get install -y mariadb-server
                  sudo systemctl start mariadb-server
                else
                  echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
                  exit 1
                fi
              else
                echo "Unable to determine Linux distribution."
                exit 1
              fi
              EOF

  tags = {
    Name = "${var.prefix}-AppServer" # Unique names for each instance
  }
}

#Provisioning the Baston Host(EC2 instance) in Public subnet - Baston Host Security Group
resource "aws_instance" "BastonHost" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "vockey" #It was already created via management console. If you can also create by define key pair module.
  subnet_id                   = aws_subnet.pub_sn.id
  vpc_security_group_ids      = [aws_security_group.DB2Baston.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.prefix}-BastonHost" # Unique names for each instance
  }
}
