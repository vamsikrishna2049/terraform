# Provider Block - AWS Credentails 
# provider "aws" {
#   access_key = ""
#   secret_key = ""
#   region     = ""
#   #if you store the credentials in particular folder then give the path like below
#   #shared_credentials_files = "C:\\Users\\Vamsi Krishna\\.aws\\credentials"
# }


provider "aws" {
  region = "us-east-1"
  alias  = "Nvirg"
}
provider "aws" {
  region = "us-east-2"
  alias  = "ohio"
}
# Cloud Provider & Version
terraform {
  required_version = "<=1.4.6" #Terraform version required for your configuration
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" # around 4.0V plugin need to download.
    }
  }
}
