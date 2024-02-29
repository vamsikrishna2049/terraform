https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
please visit the above link for "aws_s3_bucket_acl" 

# # S3 Bucket
# resource "aws_s3_bucket" "s3bucket" {
#   bucket = "my-tf-test-bucket"
#   tags = {
#     Name        = "My bucket"
#     Environment = "Test"
#   }
# }

# # Applying S3 bucket ACL
# resource "aws_s3_bucket_acl" "s3_bucket" {
#   bucket = aws_s3_bucket.s3bucket.bucket
# }

# resource "aws_cloudfront_distribution" "example" {
#   origin {
#     domain_name = aws_s3_bucket.s3bucket.bucket_regional_domain_name
#     origin_id   = "S3ExampleOrigin"
#   }
#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Example CloudFront Distribution"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods        = ["GET", "HEAD", "OPTIONS"]
#     cached_methods         = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id       = "S3ExampleOrigin"
#     viewer_protocol_policy = "allow-all"
#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     min_ttl     = 0
#     default_ttl = 3600
#     max_ttl     = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
