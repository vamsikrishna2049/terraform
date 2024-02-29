#Creating Application Load Balancer 
resource "aws_lb" "test" {
  name               = "alb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.pub-sn1.id, aws_subnet.pub-sn2.id] # for creating alb you need to create min 2 subnets in 2 diff az's
  security_groups    = [aws_security_group.sg.id]
  enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = "alb"
  }
}

# Create Target Group for Application Load Balancer
resource "aws_lb_target_group" "alb-example" {
  name        = "tf-example-lb-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  health_check {
    enabled             = true
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name = "Target_group"
  }
}

#Reference:
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group



# Creating ALB listener with port 80
resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }

  depends_on = [aws_lb.web-elb]
}
