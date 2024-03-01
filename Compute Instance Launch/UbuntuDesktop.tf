#automation script given by gccloud 
resource "google_compute_instance" "vamsiubuntu" {
  boot_disk {
    auto_delete = true
    device_name = "vamsiubuntu"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2210-kinetic-amd64-v20230615"
      size  = 10
      type  = "pd-balanced"
    }
    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  description         = "Enabling Ubuntu GUI "
  enable_display      = true
  labels = {
    goog-ec-src = "vm_add-tf"
  }

  # machine_type = "e2-medium"
  # metadata = {
  #   startup-script = "#update local machine\napt update -y && apt-get upgrade -y\n#install ubuntu dekstop\napt install ubuntu-desktop -y\n#no machine for GUI \nwget https://download.nomachine.com/download/8.5/Linux/nomachine_8.5.3_1_amd64.deb\napt install ./nomachine_8.5.3_1_amd64.deb\n\n#Edge Beta Download\ncurl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg\nsudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg\necho \"deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main\" | sudo tee /etc/apt/sources.list.d/microsoft-edge-beta.list\nsudo apt update\nsudo apt install microsoft-edge-beta\nmicrosoft-edge-beta"
  # }

  name = "vamsiubuntu"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/ubuntu-automation-17-06-23/regions/us-east1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-east1-b"
}

# vi /etc/ssh/sshd_config
# # To disable tunneled clear text passwords, change to no here!
# #PasswordAuthentication yes

# adduser vamsiubuntu
# passwd

# usermod -a -G sudo,adm vamsiubuntu
# reboot
