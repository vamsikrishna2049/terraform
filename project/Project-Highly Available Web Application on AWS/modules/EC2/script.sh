#!/bin/bash
# Determine Linux distribution
if [ -f /etc/os-release ]; then
    # Source the /etc/os-release file to get distribution information
    . /etc/os-release

    if [[ $NAME == *"Amazon Linux"* ]]; then
        # Install and start Apache on Amazon Linux
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        
        # Create an index.html file with a deployment message
        sudo sh -c "echo '<h1>Terraform on prefix-pub</h1>' > /var/www/html/index.html"

    # Update package repository and install Apache on Ubuntu/Debian
    elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
        sudo apt-get update
        sudo apt-get install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx

        # Create an index.html file with a deployment message
        sudo sh -c "echo '<h1>Deployed via Terraform on ${var.prefix}-pvt-${count.index + 1}</h1>' > sudo tee /var/www/html/index.nginx-debian.html"
    else
        echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
        exit 1
    fi
else
    echo "Unable to determine Linux distribution."
    exit 1
fi
