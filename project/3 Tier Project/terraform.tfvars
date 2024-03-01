prefix           = "dev"
instance_tenancy = "default"
instance_type    = "t2.micro"
environment      = "developer"
templateVersion  = "default"
vpc_cidr_block   = "10.0.0.0/16"
az_a             = "us-west-2a"
az_b             = "us-west-2b"
az_c             = "us-west-2c"
pub_sn_cidr1     = "10.0.1.0/24"
pub_sn_cidr2     = "10.0.2.0/24"
pub_sn_cidr3     = "10.0.3.0/24"
pvt_sn_cidr1     = "10.0.10.0/24"
pvt_sn_cidr2     = "10.0.20.0/24"
pvt_sn_cidr3     = "10.0.30.0/24"

ami_id = "ami-01e82af4e524a0aa3" #US-west-2 Amazon Linux
#ami_id          = "ami-008fe2fc65df48dac" # US-west-2 Ubuntu
