#AWS Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

#Downloading the latest version of AWS provider 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "remote-tf-state-files"
    key    = "application.tf"
    region = "us-east-1"

  }
}

#5.11.0 Launched on 03-08-23
