# S3 Bucket
resource "aws_s3_bucket" "s3bucket" {
  bucket = "venkatavamsiramakrishnabucket"
  tags = {
    Name        = "Name"
    Environment = "Test"
  }
}

#S3 Bucket Ownership
resource "aws_s3_bucket_ownership_controls" "bucketOwnership" {
  bucket = aws_s3_bucket.s3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
# # Creating a DynamoDB Table
# resource "aws_dynamodb_table" "terraform_state_lock_table" {
#   name         = "tf-state-files"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# # terraform {
# #   backend "s3" {
# #     bucket = "tf-dynamodb-state-file"
# #     key    = "${terraform.workspace}/${formatdate("YYYYMMDD-HHMMSS", timestamp())}/terraform.tfstate"
# #     region = "us-east-1"
# #   }
# # }

# terraform {
#   backend "s3" {
#     bucket = "tf-dynamodb-state-file"
#     key    = "20240131/terraform.tfstate" #Update the run date
#     region = "us-east-1"
#   }
# }
