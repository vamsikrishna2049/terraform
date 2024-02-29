# Create an S3 Bucket 
resource "aws_s3_bucket" "tf-state-file" {
  bucket = "tf-state-file-bucket-vabugb"
  tags = {
    Name        = "tf-state-file-bucket-vabugb"
    Environment = "Dev"
  }
}


# terraform {
#   backend "s3" {
#     bucket = "tf-state-file-bucket-vabugb"

#     region = "us-east-1"
#     key    = "myterraform.tfstate"
#   }
# }
