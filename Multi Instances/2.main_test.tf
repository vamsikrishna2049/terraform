#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# Create a VPC network

resource "google_compute_network" "vpc_network" {
  project                 = "my-project-name"
  name                    = "vpc-network"
  auto_create_subnetworks = true
  
}

#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# Create a Sub-network
resource "google_compute_subnetwork" "pub-sn" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.49.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
  
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
}