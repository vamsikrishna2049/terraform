
# #Step 1: Create a map 
# variable "my_map" {
#   type = map(string)
#   default = {
#     key1 = "MAPforEach1"
#     key2 = "MAPforEach2"
#     key3 = "MAPforEach3"
#   }
# }

# #Step 2: Iterate over the map using for_each
# resource "aws_iam_user" "example" {
#   for_each = var.my_map
#   name     = each.key
#   tags = {
#     value = each.value
#   }
# }
