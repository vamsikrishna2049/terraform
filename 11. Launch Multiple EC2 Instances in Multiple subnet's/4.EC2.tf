# # Creating a key pair for EC2 Instance - create the new public key and use it.
# resource "aws_key_pair" "default" { 
#   key_name   = "TFCode"
#   public_key = "ssh-rsa G/cb2TuHm+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# resource "aws_instance" "example" {
#   count                  = var.pvt_subnet_count
#   ami                    = var.ami_id
#   instance_type          = "t2.medium"
#   key_name               = "TFCode"
#   subnet_id              = element(aws_subnet.pvt_sn.*.id, count.index)
#   vpc_security_group_ids = ["${aws_security_group.TF_SG.id}"]

#   user_data = <<-EOF
#               #!/bin/bash
#               sudo yum update -y
#               sudo yum upgrade -y
#               sudo yum install -y net-tools curl iputils unzip
#               sudo yum install -y docker
#               sudo usermod -aG docker $USER
#               sudo service docker start
#               sudo chkconfig docker on
#               docker --version
#               curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --import -
#               sudo tee /etc/yum.repos.d/kubernetes.repo > /dev/null <<EOT
#               [kubernetes]
#               name=Kubernetes
#               baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
#               enabled=1
#               gpgcheck=1
#               repo_gpgcheck=1
#               gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#               EOT
#               sudo yum install -y kubelet kubeadm kubectl
#               sudo yum install -y yum-plugin-versionlock
#               sudo yum versionlock add kubelet kubeadm kubectl
#               kubeadm version
#               EOF

#   provisioner "remote-exec" {
#     inline = [
#       "sleep 60" // Wait for the instance to initialize properly
#     ]
#   }
#   tags = {
#     Name = "TF-${count.index + 1}-Pvt-Machine"
#   }
# }


# # # Define the EC2 instance in private subnet's
# # resource "aws_instance" "pvt-ser" {
# #   count                  = var.pvt_subnet_count
# #   ami                    = var.ami_id
# #   instance_type          = "t2.micro"
# #   key_name               = "TFCode"
# #   subnet_id              = element(aws_subnet.pvt_sn.*.id, count.index)
# #   vpc_security_group_ids = ["${aws_security_group.TF_SG.id}"]
# #   tags = {
# #     Name = "TF-${count.index + 1}-Pvt-Machine"
# #   }
# # }
