# terraform {
#   backend "s3" {
#     bucket         = "my-ews-baket1"
#     region         = "us-east-1"
#     key            = "DevOps Project-11/terraform.tfstate"
#     dynamodb_table = "Lock-Files"
#     encrypt        = true
#   }
# }
