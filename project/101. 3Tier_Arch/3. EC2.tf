# Creating a key pair for EC2 Instance
resource "aws_key_pair" "default" {
  key_name   = "TFCode"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOdNpkBe9+W5d3SlZT5N0PgzbuWpKCVxrg4smPmvZNWVYSk+xejefPrh+/zB8fY6ly4FnhrqEHJJWvLErf/94Vqn3oMHvnw5iOVZ6BJysIN1geSpAmvOMB4HoT9Aw004EiqtuOuuenCzOgnI8dYM4u+d0zoGmxzvJZ2OtcaQ18kJr9WfNvlLc48q0Ly1UsUVhyG5WSVqLcQe+qfrex8+p9lzLFWrmz/ICRDHwN3RON+uesJ7LIs5ZfCc7+7Pjr/4kR5sdJOozQUOXNU4kGL6j7kaBEPnTPDn16mMIbxQk55g9cyP4KZmKYcAJFF97BcOD57P4mSY8zPr7/v+l3Rrh/ krishnap201997@gmail.com"
  tags = {
    Name = "TFCode"
  }
}

# Define the EC2 instance in public subnet's
resource "aws_instance" "web" {
  count                       = var.pub_subnet_count
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.default.key_name
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  tags = {
    Name = "Web Server"
  }
}

resource "aws_instance" "db" {
  count                  = var.pvt_subnet_count
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.default.key_name
  subnet_id              = aws_subnet.private[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}

#Load Balancer
resource "aws_lb" "alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "test"
  }
}

//Target Group
resource "aws_lb_target_group" "albtg" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }
}

resource "aws_lb_target_group_attachment" "front_end" {
  count            = var.pvt_subnet_count
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.db[count.index].id
  port             = 80
}


//Listener
resource "aws_lb_listener" "albl" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn
  }
}
