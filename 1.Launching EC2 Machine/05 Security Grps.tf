# # Creating a Security Group
# resource "aws_security_group" "sg" {
#   vpc_id = aws_vpc.vpc.id
#   # if youre not provide name and description then terraform code will provide the default values.
#   # name        = terraform-YYYYMMDDHHMM......
#   # description = Managed by terraform
#   name        = "TF-SG"
#   description = "TF-SG Allow inbound traffic"

#   ingress {
#     description = "VPC Allow In-Bound Traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = -1 # All
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "TF-SG"
#   }
# }


# output "sgroup" {
#   value = aws_security_group.sg.id
# }

# # Reference
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# # Import
# # Security Groups can be imported using the security group id, e.g.,
# # $ terraform import aws_security_group.default_sg sg-903004f8
