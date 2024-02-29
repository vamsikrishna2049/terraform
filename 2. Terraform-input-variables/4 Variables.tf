# #Variables in string format
# resource "aws_instance" "ec2_example" {
#   ami           = "ami-0767046d1677be5a0"
#   instance_type = var.instance_type
#   tags = {
#     Name = "Terraform EC2"
#   }
# }

# variable "instance_type" {
#   description = "Instance type t2.micro"
#   type        = string
#   default     = "t2.micro"
# }

# variable "instance_count" {
#   description = "EC2 instance count"
#   type        = number
#   default     = 2
# }

# #========================================================================

# #Variable Declaration in Number format
# resource "aws_instance" "ec2_example" {

#   ami           = "ami-0767046d1677be5a0"
#   instance_type = "t2.micro"
#   count         = var.instance_count

#   tags = {
#     Name = "Terraform EC2"
#   }
# }

# variable "instance_count" {
#   description = "EC2 instance count"
#   type        = number
#   default     = 2
# }

# #========================================================================

# resource "aws_instance" "ec2_example" {

#   ami                         = "ami-0767046d1677be5a0"
#   instance_type               = "t2.micro"
#   count                       = 1
#   associate_public_ip_address = var.enable_public_ip

#   tags = {
#     Name = "Terraform EC2"
#   }

# }

# variable "enable_public_ip" {
#   description = "Enable public IP address"
#   type        = bool
#   default     = true
# }

# #=========================LIST===============================================
# #Listing all the IAM users
# resource "aws_instance" "ec2_example" {
#   ami           = "ami-0767046d1677be5a0"
#   instance_type = "t2.micro"
#   count         = 1

#   tags = {
#     Name = "Terraform EC2"
#   }
# }

# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# variable "user_names" {
#   description = "IAM usernames"
#   type        = list(string)
#   default     = ["user1", "user2", "user3s"]
# }

# #==========================MAP==============================================
# #Terraform also supports the map variable type where you can define the key-valye pair.
# resource "aws_instance" "ec2_example" {

#   ami           = "ami-0767046d1677be5a0"
#   instance_type = "t2.micro"

#   tags = var.project_environment

# }


# variable "project_environment" {
#   description = "project name and environment"
#   type        = map(string)
#   default = {
#     project     = "project-alpha",
#     environment = "dev"
#   }
# }


# #========================================================================

# #========================================================================
