provider "aws" {
  access_key = "ASIA2NRBEINIZIPJS7UH"
  secret_key = "QA+qgOaJnafU+4c/9c4TQJJAam0AYddU7PCiW+fl"
  region     = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
