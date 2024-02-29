# # # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "default" {
#   key_name   = "Test"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClLjy/D0U1oZLyVWC5ygvoSrITtysBfgOPXXD3j2AWNA7slUs3tcSFSOtCgmYn1P2J1B1hkutKkRn9RAPTJ7InREF1o/M55Md+dGlFM/rLOxrtvGCMwSbIyQ3vvcqE/HCB2kdzZzCZOcAxhdu8dGQOg3fEOV77dEiELQIwKUpm6ica1OkSZEQ9S5qn6YSQrQReCOV2ajBf4WZZaWNft387dmoqqDdrgCSg9rwcy9iFPTvsVqEy5PW5QWdlxDBnWvmw3flmtMr8JTmacMUvbRCbCwwsoa7gcBGKeq9AeWarjgIMmWuD3uBrsQLzqcG9PpGfvCIBUqSqkr9CRcMn8IP5 TFCode"
#   tags = {
#     Name = "TFCode"
#   }
# }

# # # Note:
# # #   Key Pairs can be imported using the key_name, e.g.,
# # #   $ terraform import aws_key_pair.deployer deployer-key

# # # Reference
# # # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# # # It's a laptop key pair
