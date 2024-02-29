# # Define the EC2 instance
# resource "aws_instance" "RHEL" {
#   ami                    = "ami-053b0d53c279acc90"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.pub-sn.id
#   vpc_security_group_ids = [aws_security_group.sg.id]
#   key_name               = aws_key_pair.default.id
#   tags = {
#     Name = "Ubuntu-Master"
#   }
# }
