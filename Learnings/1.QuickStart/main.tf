# VPC Creation - In GCP, VPC are global level and Subnets are region level

#VPC Creation
resource "google_compute_network" "vpc" {
  name                    = "demo-vpc"
  auto_create_subnetworks = false
}

#Subnet Creation
resource "google_compute_subnetwork" "subnet" {
  name          = "demo-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/24"
}

# Security Groups
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}


resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {} # Public IP
  }

  metadata_startup_script = file("startup.sh")
}
