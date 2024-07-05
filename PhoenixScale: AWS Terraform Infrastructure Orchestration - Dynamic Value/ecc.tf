# use data source to get a registered REHL 9 AMI
data "aws_ami" "redhat_linux_9_x86" {
  most_recent = true
  owners      = ["309956199498"] # Red Hat's AWS account ID

  filter {
    name   = "name"
    values = ["RHEL-9*-x86_64*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# Launch EC2 instances in particular public subnet
# resource "aws_instance" "ec2_instance" {
#   ami                    = data.aws_ami.redhat_linux_9_x86.id
#   instance_type          = "t2.micro"
#   subnet_id              = element(keys(aws_subnet.pub_sn), 0) # Choose the first public subnet
#   vpc_security_group_ids = [aws_security_group.web_sg.id]
#   key_name               = "keypair"
#   user_data              = file("installtech.sh")

#   tags = {
#     Name = "Testing machine"
#   }
# }

# Launch EC2 instances in each public subnet
# resource "aws_instance" "ec2_instance" {
#   for_each               = aws_subnet.pub_sn
#   ami                    = data.aws_ami.redhat_linux_9_x86.id
#   instance_type          = var.instance_type
#   subnet_id              = each.value.id
#   vpc_security_group_ids = [aws_security_group.web_sg.id]
#   key_name               = var.keypair
#   user_data              = file("redhat-install.sh")

#   tags = {
#     Name = "Testing machine in ${each.value.availability_zone}"
#   }
# }


