#values passing from here
region  = "us-east-1"
profile = "default" #It will search for credentials in local directory (Windows/Linux). (C:\Users\Vamsi Krishna\.aws\credentials)
#If the profile named match then using those cred, build the infra. Ex: default, admin, developer etc.
vpc_name              = "tf-vpc"
vpc_cidr_block        = "10.1.0.0/16"
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"] #List Format
pub_subnet_count      = "1"
pub_subnet_cidr_block = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"] #List Format
pvt_subnet_cidr_block = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
pvt_subnet_count      = "1"
# ami_id                = "ami-0ad86651279e2c354"

#Map Format - from line 2(region) - It will take the ami
amis = {
  us-east-1 = "ami-0c7217cdde317cfec" #Ubuntu
  us-east-2 = "ami-05fb0b8c1424f266b" #Ubuntu
}
instance_type = "t2.nano"
key_name      = "Laptop"
