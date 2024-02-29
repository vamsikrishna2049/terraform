# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

terraform {
  required_version = "<=1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
