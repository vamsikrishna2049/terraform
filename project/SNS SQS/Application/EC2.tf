# # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "default" {
#   key_name   = "TFCode"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClLjy/D0U1oZLyVWC5ygvoSrITtysBfgOPXXD3j2AWNA7slUs3tcSFSOtCgmYn1P2J1B1hkutKkRn9RAPTJ7InREF1o/M55Md+dGlFM/rLOxrtvGCMwSbIyQ3vvcqE/HCB2kdzZzCZOcAxhdu8dGQOg3fEOV77dEiELQIwKUpm6ica1OkSZEQ9S5qn6YSQrQReCOV2ajBf4WZZaWNft387dmoqqDdrgCSg9rwcy9iFPTvsVqEy5PW5QWdlxDBnWvmw3flmtMr8JTmacMUvbRCbCwwsoa7gcBGKeq9AeWarjgIMmWuD3uBrsQLzqcG9PpGfvCIBUqSqkr9CRcMn8IP5 TFCode"
#   tags = {
#     Name = "TFCode"
#   }
# }

# # Define the EC2 instance in the blue VPC with Amazon Linux
# resource "aws_instance" "pub-amazon-linux" {
#   vpc_security_group_ids = [aws_security_group.blue_TF_SG.id]
#   subnet_id              = aws_subnet.blue.id
#   ami                    = var.blue_amazon_linux_ami_id
#   instance_type          = "t2.micro"
#   key_name               = "TFCode"
#   tags = {
#     Name = "${var.blue_vpc}-amazon-linux"
#   }
# }
