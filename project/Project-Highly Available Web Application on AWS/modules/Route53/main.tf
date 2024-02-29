#Creating a Hosting Zone
resource "aws_route53_zone" "example" {
  name = "awsgooglecloud.shop"

  tags = {
    Name = "${var.prefix}-awsgcpcloud"
  }
}

#Simple Routing
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www"
  type    = "A"
  ttl     = 300
  # Example of selecting the first IP address from the tuple
  records = [var.ipAddress[0]]

}

# #Creating CName Record
# resource "aws_route53_record" "example_cname" {
#   zone_id = aws_route53_zone.example.zone_id
#   name    = "www"
#   type    = "CNAME"
#   ttl     = 300
#   records = ["my-app.example.com"]
# }


# #Creating a Health Check
# resource "aws_route53_health_check" "example_health_check" {
#   type              = "HTTP"
#   port              = 80
#   resource_path     = "/"
#   failure_threshold = 3
#   request_interval  = 30
#   ip_address        = var.ip_address
# }


# #Create ACM Certificate
# resource "aws_acm_certificate" "cert" {
#   domain_name       = "awsgooglecloud.shop"
#   validation_method = "DNS"
#   tags = {
#     Environment = "awsgooglecloud.shop"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# #Custom Domain Validation Options
# resource "aws_acm_certificate" "cert1" {
#   domain_name       = "*.awsgooglecloud.shop"
#   validation_method = "DNS"
# }
