#!/bin/bash

# Determine Linux distribution
if [ -f /etc/os-release ]; then
  # Source the /etc/os-release file to get distribution information
  . /etc/os-release

  if [[ $NAME == *"Amazon Linux"* ]]; then
    sudo yum install httpd -y             # Installing httpd server
    sudo systemctl start httpd.service    #Starting httpd server
    sudo systemctl enable httpd.service   #enabling http server
    sudo yum install mariadb105-server -y # Install mariaDB
    sudo systemctl start mariadb          # Start MariaDB service
    sudo systemctl enable mariadb         # Enable MariaDB to start on boot
    sudo sh -c "echo '<h1>This web page is coming from Amazon Linux launched on AWS cloud. This is an HTTPD Web server.</h1>' > /var/www/html/index.html"

  elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
    sudo apt update -y
    sudo apt install -y nginx        # Installing nginx package
    sudo systemctl start nginx       #Starting Nginx server
    sudo systemctl enable nginx      #Enable nginx server
    sudo apt install -y mysql-server # Install mysql server
    echo "MySQL server installed on Ubuntu/Debian."
  else
    echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
    exit 1
  fi
else
  echo "Unable to determine Linux distribution."
  exit 1
fi
