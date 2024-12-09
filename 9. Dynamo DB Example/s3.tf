https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
this code is for public acl's for private acl please visit the above link 

# Create the S3 bucket with a specified name and tags
resource "aws_s3_bucket" "practisedomain" {
  bucket = "practisedomain.cloud" # Bucket name (must be globally unique)

  # Tags to help identify and manage the S3 bucket
  tags = {
    Name        = "My S3 Bucket" # Tagging the bucket with a descriptive name
    Environment = "Production"   # Tagging the bucket with the environment name (e.g., production, staging)
  }
}

# Set versioning configuration for the S3 bucket
resource "aws_s3_bucket_versioning" "practisedomain_versioning" {
  bucket = aws_s3_bucket.practisedomain.id # Reference the bucket ID from the S3 bucket resource

  # Enable versioning to keep multiple versions of objects in the bucket
  versioning_configuration {
    status = "Enabled" # Enable versioning on the bucket
  }
}

# Set server-side encryption for the S3 bucket to secure objects at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "practisedomain_encryption" {
  bucket = aws_s3_bucket.practisedomain.id # Reference the bucket ID from the S3 bucket resource

  # Apply encryption to all objects in the bucket by default
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Use AES-256 encryption for the objects (standard encryption method)
    }
  }
}

# S3 Bucket Ownership Controls to ensure the bucket owner has full control over objects
resource "aws_s3_bucket_ownership_controls" "bucketOwnership" {
  bucket = aws_s3_bucket.practisedomain.id # Reference the bucket ID from the S3 bucket resource

  # Object ownership is set to "BucketOwnerPreferred", giving full control to the bucket owner
  rule {
    object_ownership = "BucketOwnerPreferred" # Bucket owner has control over the objects, even if uploaded by other users
  }
}

# Block all public access to the S3 bucket for security purposes
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.practisedomain.id # Reference the bucket ID from the S3 bucket resource

  # Block public access at the ACL level (prevents public access through ACLs)
  block_public_acls = true # Block public ACLs on the bucket

  # Block public access at the policy level (prevents public bucket policies)
  block_public_policy = true # Block public bucket policies

  # Ignore any public ACLs set on objects (additional security measure)
  ignore_public_acls = true # Ignore public ACLs even if applied to objects

  # Restrict the bucket from being made publicly accessible, even if public policies are set
  restrict_public_buckets = true # Restrict public access at the bucket level
}

# Backend
terraform {
  backend "s3" {
    bucket = "practisedomain.cloud"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
