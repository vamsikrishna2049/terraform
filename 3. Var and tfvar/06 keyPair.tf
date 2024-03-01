# Creating a key pair for EC2 Instance - create the new public key and use it.
# resource "aws_key_pair" "default" { 
#   key_name   = "TFCode"
#   public_key = "ssh-rsa G/cb2TuHm+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# Note:
#   Key Pairs can be imported using the key_name, e.g.,
#   $ terraform import aws_key_pair.deployer deployer-key

# Reference
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
