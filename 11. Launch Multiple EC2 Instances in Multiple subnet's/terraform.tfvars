#values passing from here
vpc_name              = "tf-vpc"
vpc_cidr_block        = "10.1.0.0/16"
pub_subnet_count      = "1"
pub_subnet_cidr_block = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
pvt_subnet_count      = "1"
pvt_subnet_cidr_block = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
ami_id                = "ami-0ad86651279e2c354"
