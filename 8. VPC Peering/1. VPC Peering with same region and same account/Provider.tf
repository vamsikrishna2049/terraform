#AWS Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "var.region"
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
