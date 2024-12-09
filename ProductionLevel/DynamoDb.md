```xml
# Define the provider for us-east-1
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1" # Set AWS region to US East (N. Virginia)
}

# Define the provider for us-west-2
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2" # Set AWS region to US West (Oregon)
}

# Create DynamoDB table in us-east-1 with name practisedomain.cloud-us-east-1
resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1 # Use us-east-1 provider

  hash_key                    = "myAttribute"                    # Primary key attribute
  name                        = "practisedomain.cloud-us-east-1" # Unique table name for this region
  stream_enabled              = true                             # Enable DynamoDB Streams (optional)
  deletion_protection_enabled = false                            # Disable deletion protection (default is false)
  stream_view_type            = "NEW_AND_OLD_IMAGES"             # Stream type to capture both old and new images of records (optional)
  billing_mode                = "PROVISIONED"                    # Use provisioned capacity (steady workloads)
  read_capacity               = 1                                # Set read capacity units
  write_capacity              = 1                                # Set write capacity units

  # Define attribute for the hash key
  attribute {
    name = "myAttribute"
    type = "S" # String type for the attribute
  }
}

# Create DynamoDB table in us-west-2 with name practisedomain.cloud-us-west-2
resource "aws_dynamodb_table" "us-west-2" {
  provider = aws.us-west-2 # Use us-west-2 provider

  hash_key         = "myAttribute"                    # Primary key attribute
  name             = "practisedomain.cloud-us-west-2" # Unique table name for this region
  stream_enabled   = true                             # Enable DynamoDB Streams (optional)
  stream_view_type = "NEW_AND_OLD_IMAGES"             # Stream type to capture both old and new images (optional)
  billing_mode     = "PAY_PER_REQUEST"                # Use on-demand billing (for unpredictable workloads)

  # Define attribute for the hash key
  attribute {
    name = "myAttribute"
    type = "S" # String type for the attribute
  }
}

# Create DynamoDB Global Table in both us-east-1 and us-west-2
resource "aws_dynamodb_global_table" "practisedomain_cloud" {
  depends_on = [
    aws_dynamodb_table.us-east-1, # Ensure US East table is created first
    aws_dynamodb_table.us-west-2  # Ensure US West table is created first
  ]

  name = "practisedomain.cloud" # Global Table name
  replica {
    region_name = "us-east-1" # Replica in US East
  }
  replica {
    region_name = "us-west-2" # Replica in US West
  }
}

```
<br>

## **stream_enabled**
Description: This attribute determines whether DynamoDB Streams are enabled for the table. DynamoDB Streams capture changes to items in your DynamoDB table, and you can use them for real-time data processing, auditing, or triggering other actions based on changes to the table.

## Values:
true: DynamoDB Streams are enabled for the table.
false: DynamoDB Streams are disabled.
Default: false (Streams are disabled by default).

**Usage:** 
If you want to track changes (such as inserts, updates, and deletes) to items in your DynamoDB table, you would set stream_enabled = true.
<br>
# stream_view_type
Description: This attribute defines the information that will be captured in the DynamoDB Stream when changes occur in the table. DynamoDB Streams allow you to capture different types of changes to your data, and this setting controls the content that will be written to the stream.

**Values:**
NEW_IMAGE: Only the new values of the item after an update or insert are captured.
OLD_IMAGE: Only the previous values of the item before an update or delete are captured.
NEW_AND_OLD_IMAGES: Both the new and the old values are captured, useful for tracking what changed.
KEYS_ONLY: Only the key attributes of the changed items are captured (minimal data).

**Usage:**
If you're interested in both the old and new versions of an item when it's modified, use NEW_AND_OLD_IMAGES.
```xml
stream_view_type = "NEW_AND_OLD_IMAGES"
```
<br>

## billing_mode
Description: This attribute determines the pricing model used for read and write throughput in the DynamoDB table. DynamoDB offers two billing modes:

**Provisioned:** You specify the read and write capacity units for the table. You pay for the throughput capacity you provision, regardless of whether it's used.
**On-Demand:** DynamoDB automatically adjusts throughput capacity to handle incoming traffic. You pay only for the read and write requests that you actually use. This mode is more flexible and can scale to handle unpredictable workloads.

**Values:**
PROVISIONED: You manually set the read and write capacity.
PAY_PER_REQUEST (or ON_DEMAND): DynamoDB automatically scales to meet demand and you pay for actual usage.

**Usage:**
PROVISIONED: Used when you want to specify the exact amount of read and write capacity.
PAY_PER_REQUEST: Used when you prefer to have DynamoDB automatically adjust to traffic spikes without specifying capacity upfront.

```xml
billing_mode = "PROVISIONED"
```
