resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet

    access_config {
      # Ephemeral Public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  tags = ["web"]
}