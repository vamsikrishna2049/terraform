# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
  profile    = "default"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
