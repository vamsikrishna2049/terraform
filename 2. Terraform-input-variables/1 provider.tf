# This Code helps to create VPC Creation

provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
