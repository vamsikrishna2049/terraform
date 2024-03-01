terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.63.1"
    }
  }
}


# Configure the Google Cloud provider
provider "google" {
  credentials = file("keys.json")
  project     = "phoneix-dev-382713"
  region      = "us-east1"
}
