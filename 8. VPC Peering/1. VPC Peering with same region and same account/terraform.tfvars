#values passing from here

region        = "us-west-2"
instance_type = "t2.micro"

#Red VPC Details
red_vpc               = "red"
red_vpc_cidr_block    = "10.0.0.0/16"
red_subnet_count      = 1
red_subnet_cidr_block = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
red_subnet_az         = ["us-west-2a", "us-west-2b", "us-west-2c"]
red_rhel_ami_id       = "ami-01cd4de4363ab6ee8" #Amazon Linux::us-west-2

#White VPC Details
white_vpc               = "white"
white_vpc_cidr_block    = "192.168.0.0/16"
white_subnet_count      = 1
white_subnet_cidr_block = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24"]
white_subnet_az         = ["us-west-2a", "us-west-2b", "us-west-2c"]
white_ubuntu_ami_id     = "ami-01cd4de4363ab6ee8" #Amazon Linux::us-west-2
