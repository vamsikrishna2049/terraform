#AWS Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "remote-tf-state-files"
    key    = "application.tf"
    region = "us-east-1"

  }
}
