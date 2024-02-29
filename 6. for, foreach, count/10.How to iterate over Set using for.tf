# for loop
# The for loop is pretty simple and if you have used any programming language.
# before then I guess you will be pretty much familiar with the for loop.

#Step 1: Create a set
variable "my_set" {
  type    = set(string)
  default = ["value1", "value2", "value3"]
}

#Step 2: Conver it to the list
locals {
  my_list = tolist(var.my_set)
}

#Step 3: Use for loop
resource "aws_vpc" "example" {
  for_each = { for idx, value in local.my_list : idx => value }

  name = each.value
}
