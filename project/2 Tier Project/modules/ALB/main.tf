# Creating Launch template - AutoScaling Group
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "name" {
  name                   = "${var.prefix}-launch-template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.aws_security_group]
  user_data              = filebase64("./modules/ALB/deploy.sh")
  description            = var.templateVersion
}

#Auto Scaling Groups
resource "aws_autoscaling_group" "name" {
  name                = "${var.prefix}-autoscaling"
  vpc_zone_identifier = [var.pub_sn_1, var.pub_sn_2]
  max_size            = 4
  min_size            = 2
  health_check_type   = ""

  launch_template {
    id      = aws_launch_template.name.id
    version = aws_launch_template.name.latest_version
  }
}

#Creating Application Load Balancer 
resource "aws_lb" "web_tg" {
  name               = "${var.prefix}-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group]
  subnets            = [data.aws_subnet.public-subnet1.id, data.aws_subnet.public-subnet2.id]

  enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Name = "${var.prefix}-alb"
  }
}

# Creating Target Group for Web-Tier 
resource "aws_lb_target_group" "web_tg" {
  name = "${var.prefix}-tg"
  health_check {
    enabled             = true
    interval            = 10
    path                = "/index.html"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "${var.prefix}-alb-tg"
  }
  depends_on = [aws_lb.web_tg]
}


# Creating ALB listener with port 80 and attaching it to Web-Tier Target Group
resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web_tg.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
  depends_on = [aws_lb.web_tg]
}