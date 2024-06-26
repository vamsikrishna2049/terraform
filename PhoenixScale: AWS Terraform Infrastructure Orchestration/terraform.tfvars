#VPC Name
vpc_name = "tf-vpc"

#VPC CIDR Range
vpc_cidr_block = "10.0.0.0/16"

#Total Public SUbnet's are created
pub_subnet_count = "2"

# Public Subnet CIDR Range
pub_subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

# Ec2 machine AZ
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

#Instance Count
instance_count = 0

#Instance Type
instance_type = "t2.nano"

#AMI ID
ami_id = "ami-08a0d1e16fc3f61ea"

#Key Pair Name
key_name = "Test-KeyPair"
