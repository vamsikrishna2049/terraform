# S3 Bucket Creation
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "dynamodb-terraform-state-bucket"
}

# Creating a DynamoDB Table
resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = "your-terraform-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}


#   backend "s3" {
#     bucket         = "dynamodb-terraform-state-bucket"
#     key            = "20240131/statefile.tfstate" # Correct way to create a dynamic key
#     region         = "us-east-1"                  # Specify your desired AWS region
#     encrypt        = true
#     dynamodb_table = "your-terraform-state-lock-table"
#   }
# }

variable "timestamp_format" {
  default = "YYYYMMDD-HHMMSS"
}

terraform {
  backend "s3" {
    bucket         = "dynamodb-terraform-state-bucket"
    key            = "${var.s3_key_prefix}/${formatdate(var.timestamp_format, timestamp())}/statefile.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = aws_dynamodb_table.terraform_state_lock_table.name
  }
}
