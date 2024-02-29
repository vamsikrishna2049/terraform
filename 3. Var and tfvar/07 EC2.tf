# # Define the EC2 instance
# resource "aws_instance" "ubuntu" {
#   ami                    = "ami-024e6efaf93d85776"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.RED-PUB-SN-1A.id
#   vpc_security_group_ids = [aws_security_group.RED-SG.id]
#   key_name               = aws_key_pair.deployer.id
#   tags = {
#     Name = "ubuntuMachine"
#   }
# }
