#!/bin/bash

# Determine Linux distribution
if [ -f /etc/os-release ]; then
  # Source the /etc/os-release file to get distribution information
  . /etc/os-release

  if [[ $NAME == *"Amazon Linux"* ]]; then
    sudo yum update -y
    sudo yum install mariadb -y
    echo "MySQL server installed on Amazon Linux."

  elif [[ $NAME == "Ubuntu" || $NAME == "Debian" ]]; then
    # Install MySQL on Ubuntu/Debian
    sudo apt update -y
    sudo apt install -y mysql-server
    echo "MySQL server installed on Ubuntu/Debian."
  else
    echo "This is not an Ubuntu or Red Hat (Amazon Linux) instance."
    exit 1
  fi
else
  echo "Unable to determine Linux distribution."
  exit 1
fi
