#AWS Credentails and region
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

#Terraform provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}
