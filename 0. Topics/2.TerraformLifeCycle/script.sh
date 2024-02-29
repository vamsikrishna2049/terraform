#!/bin/bash
sudo apt update -y && apt upgrade -y
sudo apt install -y git nginx jq
sudo git clone https://github.com/vamsikrishna2049/terraformTest.git test
cd /test
sudo cp index.html /var/www/html/index.html
sudo service nginx restart
