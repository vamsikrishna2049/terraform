# provider "aws" {
#   access_key = "AKIA27NVFPX7XKKSB75P"
#   secret_key = "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"
#   region     = "us-east-1"
# }

provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
