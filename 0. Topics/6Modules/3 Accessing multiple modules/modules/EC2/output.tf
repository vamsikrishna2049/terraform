#Public EC2 Instances
output "pub_ec2_inst_ids" {
  value = aws_instance.public_subnet[*].id
}

# #Private EC2 Instances
# output "pvt_ec2_inst_ids" {
#   value = aws_instance.private_subnet[*].id
# }
