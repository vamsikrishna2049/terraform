# Define the primary AWS provider for us-east-1 region
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

# Define the secondary AWS provider for us-east-2 region (where the replica will be created)
provider "aws" {
  alias  = "secondary"
  region = "us-east-2"
}

# Create the primary DynamoDB table in the us-east-1 region
resource "aws_dynamodb_table" "primary" {
  provider     = aws.primary                      # Use the primary provider (us-east-1)
  name         = "practisedomain.cloud-us-east-1" # Name of the DynamoDB table in primary region
  hash_key     = "LockID"                         # The primary key (hash key) for the table
  billing_mode = "PAY_PER_REQUEST"                # The billing mode, which is on-demand (no provisioned throughput)

  # Define the attribute for the hash key
  attribute {
    name = "LockID" # Attribute name for the hash key
    type = "S"      # Attribute type: String
  }

  # Use lifecycle settings to ignore changes to replica settings, which are managed separately
  lifecycle {
    ignore_changes = [replica] # Ignore changes to the replica configuration to avoid unwanted updates
  }

  # Ensure you're not changing the Stream settings if this is part of a Global Table
  stream_enabled   = true                 # Or `false`, depending on your requirements
  stream_view_type = "NEW_AND_OLD_IMAGES" # Example, you can choose based on your needs

  # allows you to restore your DynamoDB table to any second within the retention period (up to 35 days), which is required for the export operation to S3.
  point_in_time_recovery {
    enabled = true # Enable PITR
  }

  # Tag the DynamoDB table with region information for better resource identification
  tags = {
    "Region" = "us-east-1" # Tag the table with region information (useful for resource management)
  }
}

# Create a replica DynamoDB table in the secondary region (us-east-2)
resource "aws_dynamodb_table_replica" "replica" {
  provider         = aws.secondary                  # Use the secondary provider (us-east-2)
  global_table_arn = aws_dynamodb_table.primary.arn # Reference the ARN of the primary table to enable replication

  # Tag the replica with a custom name for identification
  tags = {
    Name = "practicedomain-replica-us-east-2" # Tag the replica table with a name for clarity
  }
}

# Reference the primary DynamoDB table created in us-east-1
resource "aws_dynamodb_table_export" "example" {
  s3_bucket = "practisedomain.cloud"         # S3 Bucket name for export (fixed as per your requirement)
  table_arn = aws_dynamodb_table.primary.arn # Reference the ARN of the primary DynamoDB table in us-east-1
}


# It will take around 8min time to create the entire infrastructure.
