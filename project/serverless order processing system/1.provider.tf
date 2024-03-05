# AWS CLI Credentials
provider "aws" {
  access_key               = ""
  secret_key               = ""
  region                   = ""
  alias                    = "default" # AWS CLI has different Profiles. Now i'm using default user credentials and provisioning the resources.
  # In this Path aws credentails are available.
  #shared_credentials_files = ["/Users/tf_user/.aws/creds"]
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
