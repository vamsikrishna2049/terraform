# # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "default" {
#   key_name   = "TFCode"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi42B7pH8JnIdDhlArVEv186uPA/I2mTGtdCTPaxwuSzw1/ckaAgTN2kNXG/cb2TuHm+NC7AoaucQeYFuj55btZsclaHl9UIEZAVbO888EDdy7nKTZ7rrwgxRHCTzN01YqyZbzevvi5iQqkSom+Mj/0X2frFIgzykU/lBNV2hVcVDauWF/n2gbwBZD4f6tg160bmQvxMU3mgGxPeytsNs8ivQKN5Yd5s4PoPDNHzeJr4wTid4HygUy4uUi5ENiaYadMg0JP8GsgZdVqowwNmRMlJuuQbqWb51s42/rIs25qcwDgLtD96JbNs2MQz+hvYFb9053yQsTqA1egF28As5H k@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# Define the EC2 instance in public subnet's
resource "aws_instance" "public_subnet" {
  # count                  = var.pub_instance_count
  count                  = var.environment == "production" ? 3 : 1
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "VockeyPair"
  # subnet_id              = element(module.vpc.public_subnets, 0)
  subnet_id = element(var.public_subnets,count.index)
  # vpc_security_group_ids = [module.vpc.security_group_id]
  vpc_security_group_ids = [var.sg_name]
  associate_public_ip_address = "true"

  tags = {
    Name = "${var.prefix}-pub-sn-${count.index + 1}"
  }
}

# #Define the EC2 instance in private subnet's
# resource "aws_instance" "private_subnet" {
#   count                  = var.pvt_instance_count
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   key_name               = "TFCode"
#   subnet_id              = element(module.vpc.private_subnets, 0)
#   vpc_security_group_ids = [module.vpc.security_group_id]
#   tags = {
#     Name = "${var.prefix}-pvt-sn-${count.index + 1}"
#   }
# }
