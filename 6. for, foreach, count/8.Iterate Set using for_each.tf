# resource "aws_iam_user" "example" {
#   for_each = var.user_names
#   name     = each.value
# }

# variable "user_names" {
#   description = "IAM usernames"
#   type        = set(string)
#   default     = ["user1", "user2", "user3"]
# }