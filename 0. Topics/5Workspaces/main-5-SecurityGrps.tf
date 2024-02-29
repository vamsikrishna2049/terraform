# Creating a Security Group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id
  # if youre not provide name and description then terraform code will provide the default values.
  # name        = terraform-YYYYMMDDHHMM......
  # description = Managed by terraform
  name        = "TF-SG"
  description = "TF-SG Allow inbound traffic"

  ingress {
    description = "VPC Allow In-Bound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1 # All
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-SG"
  }
}

# # aws_security_group.SG will be created
# + resource "aws_security_group" "SG" {
#     + arn                    = (known after apply)
#     + description            = "TF-SG Allow inbound traffic"
#     + egress                 = [
#         + {
#             + cidr_blocks      = [
#                 + "0.0.0.0/0",
#               ]
#             + description      = ""
#             + from_port        = 0
#             + ipv6_cidr_blocks = []
#             + prefix_list_ids  = []
#             + protocol         = "-1"
#             + security_groups  = []
#             + self             = false
#             + to_port          = 0
#           },
#       ]
#     + id                     = (known after apply)
#     + ingress                = [
#         + {
#             + cidr_blocks      = [
#                 + "0.0.0.0/0",
#               ]
#             + description      = "VPC Allow In-Bound Traffic"
#             + from_port        = 0
#             + ipv6_cidr_blocks = []
#             + prefix_list_ids  = []
#             + protocol         = "-1"
#             + security_groups  = []
#             + self             = false
#             + to_port          = 0
#           },
#       ]
#     + name                   = "TF-SG"
#     + name_prefix            = (known after apply)
#     + owner_id               = (known after apply)
#     + revoke_rules_on_delete = false
#     + tags                   = {
#         + "Name" = "dev-SG"
#       }
#     + tags_all               = {
#         + "Name" = "dev-SG"
#       }
#     + vpc_id                 = (known after apply)
#   }
