#!/bin/bash
# Determine Linux distribution
if [ -f /etc/os-release ]; then
    # Source the /etc/os-release file to get distribution information
    . /etc/os-release

    if [[ $NAME == "Amazon Linux" ]]; then
        # Install and start mariadb-server on Amazon Linux
        sudo yum update -y
        sudo yum install mariadb-server -y
        sudo systemctl start mariadb
        sudo systemctl enable mariadb

    # Installing mariadb-server on Ubuntu/Debian
    elif [[ $NAME == "Ubuntu" ]]; then
        sudo apt-get update
        sudo apt-get install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx

    else
        echo "This is $NAME Linux distribution."
        exit 1
    fi
else
    echo "Unable to find the Linux distribution."
    exit 1
fi
