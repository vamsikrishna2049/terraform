Reference:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
Below code will be for public acl please visit the above document link


resource "aws_s3_bucket" "example" {
  bucket = "my-tf-example-bucket"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Block S3 Public Access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.s3bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Applying S3 bucket ACL
resource "aws_s3_bucket_acl" "s3_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.bucketOwnership, aws_s3_bucket_public_access_block.example]
  bucket     = aws_s3_bucket.s3bucket.id
  acl        = "public-read-write"
}

#Backend
terraform {
  backend "s3" {
    bucket = "venkatavamsiramakrishnabucket"
    key    = "devmodules.tfstate"
    region = "us-east-1"
  }
}