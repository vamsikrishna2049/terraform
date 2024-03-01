# # Creating a key pair for EC2 Instance - create the new public key and use it.
# resource "aws_key_pair" "default" { 
#   key_name   = "TFCode"
#   public_key = "ssh-rsa G/cb2TuHm+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# # Define the EC2 instance in the Red VPC with RHEL
# resource "aws_instance" "rhel" {
#   vpc_security_group_ids = [aws_security_group.red_TF_SG.id] # Use the ID of the security group created earlier
#   subnet_id              = aws_subnet.red.id                 # Use the ID of the public subnet in the red VPC
#   ami                    = var.red_rhel_ami_id
#   instance_type          = "t2.micro"
#   key_name               = "TFCode"
#   tags = {
#     Name = "${var.red_vpc}-rhel"
#   }
# }


# # Define the EC2 instance in the White VPC with Ubuntu
# resource "aws_instance" "pub-ubuntu" {
#   vpc_security_group_ids = [aws_security_group.white_TF_SG.id]
#   subnet_id              = aws_subnet.white.id
#   ami                    = var.white_ubuntu_ami_id
#   instance_type          = "t2.micro"
#   key_name               = "TFCode"
#   tags = {
#     Name = "${var.white_vpc}-ubuntu"
#   }
# }