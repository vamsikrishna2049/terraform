# # The for_each is a little special in Terraform and you can not use it on any collection variable.
# # Note:
# # 1. It can only be used on set(string) or map(string).
# # 2. The reason why for_each does not work on list(string) is because a list can contain duplicate values.
# #     But if you are using set(string) or map(string) then it does not support duplicate values.

# # How to make for_each work with list? -
# # First you need to get rid of the duplicate values inside the list
# # You need to convert(cast) list into set using the toset() function.

# #Step 1: Create a list varible
# variable "my_list" {
#   type    = list(string)
#   default = ["value1", "value2", "value3"]
# }
# resource "aws_iam_user" "example" {

#   #Step 2: Convert list to set using toset() function 
#   for_each = toset(var.my_list)

#   #Step 3: Iterate over the list
#   name = each.value
# }
