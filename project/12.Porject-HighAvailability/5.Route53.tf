# #Creating health check for Route 53
# resource "aws_route53_health_check" "primary_health_check" {
#   fqdn              = "www.awsgcpcloud.shop"
#   port              = 80
#   type              = "HTTP"
#   resource_path     = "/"
#   failure_threshold = "2"  #Advanced Config
#   request_interval  = "10" #Advanced Config
#   search_string     = "cafe"

#   tags = {
#     Name = "primary-website-check"
#   }
# }

# #Creating a Hosting Zone
# resource "aws_route53_zone" "primary" {
#   name = "www.awsgcpcloud.shop"
#   tags = {
#     Name = "awsgcpcloud"
#   }
# }

# # Creating a Failover Record
# resource "aws_route53_record" "primary_failover" {
#   zone_id        = aws_route53_zone.primary.zone_id
#   name           = "www.awsgcpcloud.shop"
#   type           = "A"
#   set_identifier = "primary"
#   failover_routing_policy {
#     type = "PRIMARY"
#   }
#   ttl     = 300
#   records = ["<IP_ADDRESS_OF_PRIMARY_SERVER>"] #Enter the Primary Server IP Address
# }

# resource "aws_route53_record" "secondary_failover" {
#   zone_id        = aws_route53_zone.primary.zone_id
#   name           = "www.awsgcpcloud.shop"
#   type           = "A"
#   set_identifier = "secondary"
#   failover_routing_policy {
#     type = "SECONDARY"
#   }
#   ttl     = 300
#   records = ["<IP_ADDRESS_OF_SECONDARY_SERVER>"] #Enter the Secondary Server IP Address
# }

