#S3 Bucket Creation
resource "aws_s3_bucket" "bucket" {
  bucket = "my-terraform-example-bucket"
  tags = {
    Name = "my-terraform-example-bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Block S3 Public Access
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Applying S3 bucket ACL
resource "aws_s3_bucket_acl" "bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket, aws_s3_bucket_public_access_block.bucket]
  bucket     = aws_s3_bucket.bucket.id
  acl        = "public-read-write"
}
