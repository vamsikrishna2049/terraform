# # Step 1: Create a map variable
# variable "my_map" {
#   type = map(string)
#   default = {
#     key1 = "MAP1"
#     key2 = "MAP2"
#     key3 = "MAP3"
#   }
# }

# # Step 2: Fetch keys of the map
# locals {
#   my_keys = keys(var.my_map)
# }

# # Step 3: Iterate over the map using keys and count.index meta-argument
# resource "aws_iam_user" "example" {
#   count = length(local.my_keys)
#   name  = local.my_keys[count.index]

#   tags = {
#     value = var.my_map[local.my_keys[count.index]]
#   }
# }

# #value =3
# # Document code is updated in this code
# # uncomment on var.tf file