#Public EC2 Instances
output "pub_ec2_inst_ids" {
  value = aws_instance.public_subnet[*].id
}

output "public_ip_addresses" {
  value = aws_instance.public_subnet[*].public_ip
}