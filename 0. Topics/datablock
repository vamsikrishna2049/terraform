#Fetch the list of available availability zones in the specified region
data "aws_availability_zones" "available" {}

# Define an AWS EC2 instance resource
resource "aws_instance" "example" {
  # Iterate over the set of availability zone names
  for_each         = toset(data.aws_availability_zones.available.names)
  
  # Specify the AMI to use for the instances
  ami              = "ami-0c55b159cbfafe1f0"
  
  # Specify the instance type
  instance_type    = "t2.micro"
  
  # Assign the current availability zone to the instance
  availability_zone = each.key
}

# for_each = toset(data.aws_availability_zones.available.names): 
# This line uses a for_each loop to iterate over the list of available availability zones.
# The data.aws_availability_zones.available.names provides a list of availability zone names, and toset converts this list into a set. 
# Terraform will create one instance for each element in this set.

# availability_zone = each.key: In a for_each loop, each.key refers to the current element of the set being iterated over. 
# In this case, each.key corresponds to one of the availability zone names from the set data.aws_availability_zones.available.names. 
# This line assigns the current availability zone name to the availability_zone attribute of the instance, ensuring that each instance is placed in a different availability zone.
