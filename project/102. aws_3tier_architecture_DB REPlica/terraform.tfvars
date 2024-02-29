#TFVars
vpc_name             = "3-Tier Architecture"
vpc_cidr_block       = "10.0.0.0/16"
enable_dns_hostnames = "true"
instance_tenancy     = "default"
#Public Instacne Type
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
pub_subnet_count      = "2"
pub_subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

pvt_subnet_count      = "1"
pvt_subnet_cidr_block = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]



#EC2 Instance Type
ami_id = "ami-006dcf34c09e50022"
primary_db_allocated_storage =10
secondary_db_allocated_storage = 10

instance_class="db.t2.micro"