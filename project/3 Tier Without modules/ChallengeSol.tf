# # Creating - Database to App Security Group
# resource "aws_security_group" "DB2App" {
#   vpc_id = aws_vpc.main.id
#   name   = "${var.prefix}_db2app_sg"

#   # Edit inbound rules to allow traffic from AppSG
#   ingress {
#     description     = "Allow traffic from AppSG"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.AppSG.id]
#   }

#   # Edit outbound rules to allow traffic to DB_SG
#   egress {
#     description     = "Allow traffic to DB_SG"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.DB_SG.id]
#   }

#   tags = {
#     Name = "${var.prefix}_db2app_sg"
#   }
# }

# # Creating - Database to Bastion Security Group
# resource "aws_security_group" "DB2Baston" {
#   vpc_id = aws_vpc.main.id
#   name   = "${var.prefix}_db2baston_sg"

#   # Edit inbound rules to allow traffic from BastionHostSG
#   ingress {
#     description     = "Allow traffic from BastionHostSG"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.BastonHostSG.id]
#   }

#   # Edit outbound rules to allow traffic to DB_SG
#   egress {
#     description     = "Allow traffic to DB_SG"
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.DB_SG.id]
#   }

#   tags = {
#     Name = "${var.prefix}_db2baston_sg"
#   }
# }