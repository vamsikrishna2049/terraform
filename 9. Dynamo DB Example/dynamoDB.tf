# Creating a DynamoDB Table
resource "aws_dynamodb_table" "state_lock" {
  name         = "practisedomain.cloud"  # DynamoDB table name
  hash_key     = "LockID"                # Partition key name
  billing_mode = "PROVISIONED"           # Use provisioned throughput mode
  
  # Attribute definitions
  attribute {
    name = "LockID"
    type = "S"  # String type for LockID
  }

  # Provisioned throughput settings
  provisioned_throughput {
    read_capacity  = 5
    write_capacity = 5
  }

  tags = {
    Name        = "Terraform State Lock"
    Environment = "Production"
  }
}

# Backend Configuration (Once the table is created, then only you need to use this below block)
# backend.tf
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
