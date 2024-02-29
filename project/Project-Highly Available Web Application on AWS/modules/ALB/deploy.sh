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
        sudo cd /var/www/html
        sudo wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip
        sudo yum install unzip
        sudo unzip 2135_mini_finance.zip
        sudo rm -rf 2135_mini_finance.zip index.nginx-debian.html
        sudo cd 2135_mini_finance/
        sudo mv * ../
        sudo rm -rf 2135_mini_finance/
        sudo systemctl restart nginx
        sudo systemctl enable nginx
        sudo yum install mysql-server -y

    # Update package repository and install Apache on Ubuntu/Debian
    elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get upgrade -y
        sudo apt-get -y install nginx
        sudo cd /var/www/html
        sudo wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip
        sudo apt install unzip
        sudo unzip 2135_mini_finance.zip
        sudo rm -rf 2135_mini_finance.zip index.nginx-debian.html
        sudo cd 2135_mini_finance/
        sudo mv * ../
        sudo rm -rf 2135_mini_finance/
        sudo systemctl restart nginx
        sudo systemctl enable nginx 
        sudo apt install mysql-server -y
    else
        echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
        exit 1
    fi
else
    echo "Unable to determine Linux distribution."
    exit 1
fi
