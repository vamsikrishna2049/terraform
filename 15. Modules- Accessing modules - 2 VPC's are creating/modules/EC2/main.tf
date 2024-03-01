module "vpc" {
  source           = "../VPC"
  vpc_cidr_block   = var.vpc_cidr_block
  pub_subnet_count = var.pub_subnet_count
  pub_azs          = var.public_subnets_availability_zones
  pvt_subnet_count = var.pvt_subnet_count
  pvt_azs          = var.private_subnets_availability_zones

}

# # Creating a key pair for EC2 Instance - create the new public key and use it.
# resource "aws_key_pair" "default" { 
#   key_name   = "TFCode"
#   public_key = "ssh-rsa G/cb2TuHm+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }


# Define the EC2 instance in public subnet's
resource "aws_instance" "public_subnet" {
  count                  = var.pub_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "TFCode"
  subnet_id              = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids = [module.vpc.security_group_id]
  tags = {
    Name = "${var.prefix}-pub-sn-${count.index + 1}"
  }
}

#Define the EC2 instance in private subnet's
resource "aws_instance" "private_subnet" {
  count                  = var.pvt_instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "TFCode"
  subnet_id              = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids = [module.vpc.security_group_id]
  tags = {
    Name = "${var.prefix}-pvt-sn-${count.index + 1}"
  }
}
