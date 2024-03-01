# # Create a VPC network
# resource "google_compute_network" "vpc_network" {
#   name                    = "my-vpc-network"
#   auto_create_subnetworks = false
# }

# # Create a public subnet
# resource "google_compute_subnetwork" "public_subnet" {
#   name          = "public-subnet"
#   ip_cidr_range = "10.0.1.0/24"
#   network       = google_compute_network.vpc_network.self_link
# }

# # Create a private subnet
# resource "google_compute_subnetwork" "private_subnet" {
#   name                     = "private-subnet"
#   ip_cidr_range            = "10.0.10.0/24"
#   network                  = google_compute_network.vpc_network.self_link
#   private_ip_google_access = true
#   region = "us-east-1"

# }

# Create a firewall rule to allow incoming SSH traffic to public subnet
resource "google_compute_firewall" "ssh_firewall" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_instance" "vm-by-tf-codeterraform1" {
  boot_disk {
    auto_delete = true
    device_name = "vm-by-tf-code1"
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230302"
      size  = 10
      type  = "pd-standard"
    }
    mode = "READ_WRITE"
  }
  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false
  machine_type        = "n2-standard-2"
  metadata = {
    startup-script = "#!/bin/bash\napt update -y\ncurl https://get.docker.com | bash"
  }
  name = "vm-by-tf-code1"
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    subnetwork = "projects/phoneix-dev-382713/regions/us-east1/subnetworks/default"
  }
  zone = "us-east1-b"
}

