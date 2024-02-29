# # Creating a key pair for EC2 Instance

# resource "aws_key_pair" "deployer" {
#   key_name   = "laptop"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCCeCGr3FUnZL18EA1tvqVdyP7KrcO7Luom6fjbK/MyYtd8mzJAw+rhIF0Y0HVwM/xrpl8wsX4WdoDjGjacK64hstFJl29MCYO/yZnbXIzvwwdLW37NpxReciCbbVKjtCxlbGZvw4VajBJOiy5aum+zcq6DemIbZUsKrTsHDMt/Nj1KsFgrTCFzlCqeLZt5jUm7QE1IbmrmlzPNr5hD5KxnHj7Xyleuh/60+Gi5MN2UMwlFaDgXB1K10SyHOJdatP7uHRNfCj0+31zS75ObCcwNPPTVgJ6wTvlhXDwyfbcL4aci53tUM6S1xksgpC/RFSNO4OkGhcJIs8ebft53qLjB imported-openssh-key"
#   tags = {
#     Name = "laptop"
#   }
# }

# # Note:
# #   Key Pairs can be imported using the key_name, e.g.,
# #   $ terraform import aws_key_pair.deployer deployer-key

# # Reference
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
