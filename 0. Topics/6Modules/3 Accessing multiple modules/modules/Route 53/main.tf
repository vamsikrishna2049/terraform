#Creating a Hosting Zone
resource "aws_route53_zone" "example" {
  name = "example.com"

  tags = {
    Name = "Example.com Hosted Zone"
  }
}

# Creating a Record
resource "aws_route53_record" "example_a" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "" # Enter your desired DNS record name here
  type    = "A"

  alias {
    name                   = "my-public-ip.amazonaws.com"
    zone_id                = aws_route53_zone.example.zone_id
    evaluate_target_health = true
  }
}

#Creating CName Record
resource "aws_route53_record" "example_cname" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www"
  type    = "CNAME"

  alias {
    name                   = "my-app.example.com"
    zone_id                = aws_route53_zone.example.zone_id
    evaluate_target_health = true
  }
}

#Creating a Health Check
resource "aws_route53_health_check" "example_health_check" {
  type              = "HTTP"
  port              = 80
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
  ip_address        = "my-public-ip.amazonaws.com"
}
