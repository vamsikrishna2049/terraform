# for_each and count are both used to make multiple copies of a resource, but they work in very different ways.

# 1. count : count is an argument that takes a integer value that tells how many copies of a resource to make. 
# When you use count, each instance gets a number (starting with 0), which you can use to get to that instance.

#For example : 
#If you wanted to create three instances of an aws_instance, you might use a configuration like this:

# Following terraform code will create 3 instances of ec2
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}


#2.for_each : This option can be either a map or a set of strings.
# For each item in the map or set of strings, a new instance is made.
# The map or set gives each instance a key that can be used to get to that instance.
# Iterate over the amis set defined in the variable 
# The followig resource will create two ec2 instances. 

resource "aws_instance" "example" {
  for_each      = var.ami_id
  ami           = each.value
  instance_type = "t2.micro"
}

variable "ami_id" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["ami-0c55b159cbfafe1f0", "ami-083ac7c7ecf9bb9b0"]
}


# The main differences between count and for_each are:

# count works on a list and uses IDs that are whole numbers. 
# for_each works with a map or set, and string keys are used as keys.

# If you remove an item from the middle of your list using count, every item after it will move down to take its place, 
# and Terraform will make them all over again. With for_each, each instance has a stable identity based on its key, 
# and Terraform won't make new instances if you delete one.

# for_each gives you more freedom and control, especially when you want to make resources with different traits, 
# because you can map different resource options to values in each map or set.