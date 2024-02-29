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

#5.11.0 Launched on 03-08-23
