output "aws_s3_bucket" {
  value = aws_s3_bucket.bucket
}

# output "cloudfront_origin_access_control_id" {
#   value = aws_cloudfront_origin_access_control.default.id
# }

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}
