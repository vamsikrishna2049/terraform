terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.0"
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  credentials = file("keys.json")
  project     = "ubuntu-automation-17-06-23"
  region      = "us-east1"
  zone        = "us-east1-c"
}

# resource "google_compute_instance" "myinstance" {
#   name                      = "vamsiubuntu"
#   machine_type              = "e2-medium"
#   zone                      = "us-east1-c"
#   allow_stopping_for_update = "true"

#   boot_disk {
#     initialize_params {
#       image = "projects/ubuntu-os-cloud/global/images/ubuntu-2210-kinetic-amd64-v20230615"
#     }
#   }
#   network_interface {
#     network = "default"
#   }
# }
