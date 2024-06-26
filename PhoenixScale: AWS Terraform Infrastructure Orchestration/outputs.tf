#VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

#List all the Public Subnets
output "aws_public_subnet_id" {
  value = aws_subnet.pub_sn.*.id
}

#Security Group ID
output "security_group_id" {
  value = aws_security_group.web_sg.id
}

#EC2 Instance Public IP Address
output "instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.web[*].public_ip
}

# output "load_balancer_dns" {
#     description = "DNS name of the load balancer"
#   value = aws_lb.web_lb.dns_name
# }

# output "security_group_id" {
#     description = "Security group IDs"
#   value = aws_security_group.web_sg.id
# }
