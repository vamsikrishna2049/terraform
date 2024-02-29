#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Determine Linux distribution
if [ -f /etc/os-release ]; then
    . sudo /etc/os-release # Source the /etc/os-release file to get distribution information

    if [[ $NAME == *"Amazon Linux"* ]]; then
        # Install and start Apache on Amazon Linux
        sudo yum install httpd mysql-server unzip -y
        # Download and extract website files
        sudo wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip -P /var/www/html
        sudo unzip /var/www/html/2135_mini_finance.zip -d /var/www/html
        # sudo sh -c "echo '<h1>Terraform on prefix-pub</h1>' > /var/www/html/index.html"
        sudo rm /var/www/html/2135_mini_finance.zip
        sudo systemctl start httpd
        sudo systemctl enable httpd

    elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
        # Update package repository and install Nginx on Debian Machines
        sudo apt-get update -y
        sudo apt-get upgrade -y
        sudo apt-get install nginx mysql-server unzip -y

        # Download and extract website files
        sudo wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip -P /var/www/html
        sudo unzip /var/www/html/2135_mini_finance.zip -d /var/www/html
        sudo rm /var/www/html/2135_mini_finance.zip
    else
        echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
        exit 1
    fi
else
    echo "Unable to determine Linux distribution."
    exit 1
fi
