# #Step 1: Create a set
# variable "my_set" {
#   type    = set(string)
#   default = ["set1", "set2", "set3"]
# }

# #Step 2: Convert set to list
# locals {
#   my_list = tolist(var.my_set)
# }

# #Step 3: Use count to iterate
# resource "aws_iam_user" "example" {
#   count = length(local.my_list)
#   name  = local.my_list[count.index]
# }

# # Note:
# #     We can't work directly work with set, need to convert set from list.
