#VPC Creation

resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "TF-VPC"
  }
}

output "aws_vpc" {
  value = aws_vpc.vpc.id
}
#Note:
#   VPCs can be imported using the vpc id, e.g.
#   $ terraform import aws_vpc.test_vpc vpc-a01106c2


# Reference:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc
