# #S3 Bucket Creation
# resource "aws_s3_bucket" "example" {
#   bucket = "my-terraform-example-bucket"
# }

# resource "aws_s3_bucket_ownership_controls" "example" {
#   bucket = aws_s3_bucket.example.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# #Block S3 Public Access
# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket                  = aws_s3_bucket.example.id
#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# # Applying S3 bucket ACL
# resource "aws_s3_bucket_acl" "example" {
#   depends_on = [aws_s3_bucket_ownership_controls.example, aws_s3_bucket_public_access_block.example]
#   bucket     = aws_s3_bucket.example.id
#   acl        = "public-read-write"
# }