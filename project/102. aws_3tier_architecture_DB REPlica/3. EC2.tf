# # Creating a key pair for EC2 Instance
# resource "aws_key_pair" "default" {
#   key_name   = "TFCode"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOdNpkBe9+W5d3SlZT5N0PgzbuWpKCVxrg4smPmvZNWVYSk+xejefPrh+/zB8fY6ly4FnhrqEHJJWvLErf/94Vqn3oMHvnw5iOVZ6BJysIN1geSpAmvOMB4HoT9Aw004EiqtuOuuenCzOgnI8dYM4u+d0zoGmxzvJZ2OtcaQ18kJr9WfNvlLc48q0Ly1UsUVhyG5WSVqLcQe+qfrex8+p9lzLFWrmz/ICRDHwN3RON+uesJ7LIs5ZfCc7+7Pjr/4kR5sdJOozQUOXNU4kGL6j7kaBEPnTPDn16mMIbxQk55g9cyP4KZmKYcAJFF97BcOD57P4mSY8zPr7/v+l3Rrh/ krishnap201997@gmail.com"
#   tags = {
#     Name = "TFCode"
#   }
# }

# #Load Balancer
# resource "aws_lb" "alb" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.allow_ssh.id]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]

#   enable_deletion_protection = false

#   tags = {
#     Environment = "test"
#   }
# }

# #Target Group
# resource "aws_lb_target_group" "albtg" {
#   name        = "tf-example-lb-tg"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.main.id

#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 10
#     timeout             = 5
#     interval            = 10
#     path                = "/"
#     port                = 80
#   }
# }

# resource "aws_lb_target_group_attachment" "front_end" {
#   count            = var.pvt_subnet_count
#   target_group_arn = aws_lb_target_group.albtg.arn
#   target_id        = aws_instance.db[count.index].id
#   port             = 80
# }


# //Listener
# resource "aws_lb_listener" "albl" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       status_code  = "200"
#     }
#   }
# }


# # # Define the Primary and Secondary Database
# # resource "aws_db_instance" "primary_db" {
# #   allocated_storage       = var.primary_db_allocated_storage
# #   storage_type            = "gp2"
# #   engine                  = "mysql"
# #   engine_version          = "5.7"
# #   instance_class          = var.instance_class
# #   db_name                 = "mysql-primary" # Use db_name instead of name
# #   username                = "db_user"
# #   password                = "db_password"
# #   parameter_group_name    = "default.mysql5.7"
# #   skip_final_snapshot     = true
# #   multi_az                = true
# #   backup_retention_period = 7
# # }


# # resource "aws_db_instance" "read_replica" {
# #   count                = var.pvt_subnet_count
# #   allocated_storage    = var.secondary_db_allocated_storage
# #   storage_type         = "gp2"
# #   engine               = "mysql"
# #   engine_version       = "5.7"
# #   instance_class       = "db.t2.micro"
# #   db_subnet_group_name = aws_subnet.private.id
# #   replicate_source_db  = aws_db_instance.primary_db.id
# #   username             = "db_user"
# #   password             = "db_password"
# #   parameter_group_name = "default.mysql5.7"


# # }





# # Modify your EC2 Instances to connect to the Primary Database
# # resource "aws_instance" "example" {
# #   count                       = var.pub_subnet_count
# #   ami                         = var.ami_id
# #   instance_type               = "t2.micro"
# #   key_name                    = aws_key_pair.default.key_name
# #   subnet_id                   = aws_subnet.public[count.index].id
# #   vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
# #   associate_public_ip_address = true
# #   tags = {
# #     Name = "Web Server"
# #   }

# #   connection {
# #     host     = aws_db_instance.primary_db.address
# #     port     = 3306
# #     user     = "db_user"
# #     password = "db_password"
# #     type     = "ssh"
# #   }

# #   user_data = <<-EOF
# #     #!/bin/bash
# #     if [ -f /etc/os-release ]; then
# #       source /etc/os-release
# #       if [[ "$ID" == "ubuntu" ]]; then
# #         # Install packages for Ubuntu
# #         sudo apt update -y && sudo apt upgrade -y
# #         sudo apt install -y curl unzip net-tools iputils-ping
# #       elif [[ "$ID" == "amzn" ]]; then
# #         # Install packages for Amazon Linux
# #         sudo yum update -y && sudo yum upgrade -y
# #         sudo yum install -y curl
# #       fi
# #     fi
# #     EOF
# # }

# # resource "aws_instance" "db" {
# #   count                  = var.pvt_subnet_count
# #   ami                    = var.ami_id
# #   instance_type          = "t2.micro"
# #   key_name               = aws_key_pair.default.key_name
# #   subnet_id              = aws_subnet.private[count.index].id
# #   vpc_security_group_ids = [aws_security_group.allow_ssh_db.id]

# #   connection {
# #     host     = aws_db_instance.primary_db.address
# #     port     = 3306
# #     user     = "db_user"
# #     password = "db_password"
# #     type     = "ssh"
# #   }

# #   tags = {
# #     Name = "DB Server"
# #   }
# # }

# # output "public_ip" {
# #   value = aws_instance.example[*].public_ip
# # }

# # Define the Primary Database
# resource "aws_db_instance" "primary_db" {
#   allocated_storage       = var.primary_db_allocated_storage
#   storage_type            = "gp2"
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = var.instance_class
#   db_name                 = "mysql-primary" # Use db_name instead of name
#   username                = "db_user"
#   password                = "db_password"
#   parameter_group_name    = "default.mysql5.7"
#   skip_final_snapshot     = true
#   multi_az                = true
#   backup_retention_period = 7
# }

# # Define the Read Replica Database
# resource "aws_db_instance" "read_replica" {
#   count                = var.pvt_subnet_count
#   allocated_storage    = var.secondary_db_allocated_storage
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   db_subnet_group_name = aws_subnet.private[count.index]
#   replicate_source_db  = aws_db_instance.primary_db.id
#   username             = "db_user"
#   password             = "db_password"
#   parameter_group_name = "default.mysql5.7"
# }

# # Modify your EC2 Instances to connect to the Read Replica
# resource "aws_instance" "example" {
#   count                       = var.pub_subnet_count
#   ami                         = var.ami_id
#   instance_type               = "t2.micro"
#   key_name                    = aws_key_pair.default.key_name
#   subnet_id                   = aws_subnet.public[count.index].id
#   vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
#   associate_public_ip_address = true
#   tags = {
#     Name = "Web Server"
#   }

#   connection {
#     host     = aws_db_instance.read_replica[count.index].address
#     port     = 3306
#     user     = "db_user"
#     password = "db_password"
#     type     = "ssh"
#   }

#   user_data = <<-EOF
#     #!/bin/bash
#     if [ -f /etc/os-release ]; then
#       source /etc/os-release
#       if [[ "$ID" == "ubuntu" ]]; then
#         # Install packages for Ubuntu
#         sudo apt update -y && sudo apt upgrade -y
#         sudo apt install -y curl unzip net-tools iputils-ping
#       elif [[ "$ID" == "amzn" ]]; then
#         # Install packages for Amazon Linux
#         sudo yum update -y && sudo yum upgrade -y
#         sudo yum install -y curl
#       fi
#     fi
#     EOF
# }

# # Your existing DB instances can remain unchanged
# resource "aws_instance" "db" {
#   count                  = var.pvt_subnet_count
#   ami                    = var.ami_id
#   instance_type          = "t2.micro"
#   key_name               = aws_key_pair.default.key_name
#   subnet_id              = aws_subnet.private[count.index].id
#   vpc_security_group_ids = [aws_security_group.allow_ssh_db.id]

#   connection {
#     host     = aws_db_instance.primary_db.address
#     port     = 3306
#     user     = "db_user"
#     password = "db_password"
#     type     = "ssh"
#   }

#   tags = {
#     Name = "DB Server"
#   }
# }

# output "public_ip" {
#   value = aws_instance.example[*].public_ip
# }

