# Outputs
# It allow you to easily extract information about the resources that were created by Terraform. 
# They allow you to easily reference the values of resources after Terraform has finished running

output "aws_vpc" {
  value = aws_vpc.default.id
}

output "aws_subnet" {
  value = aws_subnet.PUB-SN.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

# output "aws_route_table" {
#   value = aws_route_table.RT-Main.id
# }

# output "sgroup" {
#   value = aws_security_group.SG.id
# }