# AWS CLI Credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
  # alias      = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  #   backend "s3" {
  #     bucket = "my-tf-example-bucket"
  #     key    = "devmodules.tfstate"
  #     region = "us-east-2"
  #   }
}
