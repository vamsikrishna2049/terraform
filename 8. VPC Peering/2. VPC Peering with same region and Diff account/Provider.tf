#AWS Credentials
# Provider Configuration for both Accounts
provider "aws" {
  alias      = "Acceptor"
  access_key = var.Acceptor_access_key
  secret_key = var.Acceptor_secret_key
  region     = "us-east-1"
}

provider "aws" {
  alias      = "Reciever"
  secret_key = var.Reciever_secret_key
  access_key = var.Reciever_access_key
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
