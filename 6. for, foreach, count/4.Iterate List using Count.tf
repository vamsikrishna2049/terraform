# #Iterate List using count -Create IAM Users
# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# variable "user_names" {
#   description = "IAM usernames"
#   type        = list(string)
#   default     = ["LIST1", "LIST2", "LIST3"]
# }
