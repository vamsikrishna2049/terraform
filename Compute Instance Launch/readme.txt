#update local machine
apt update -y && apt-get upgrade -y

#install ubuntu dekstop
apt install ubuntu-desktop -y

#no machine for GUI 
wget https://download.nomachine.com/download/8.5/Linux/nomachine_8.5.3_1_amd64.deb
apt install ./nomachine_8.5.3_1_amd64.deb

#Edge Beta Download
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge-beta.list
sudo apt update
sudo apt install microsoft-edge-beta
microsoft-edge-beta

passwd
vi /etc/ssh/sshd_config
# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes

adduser vamsiubuntu
passwd

usermod -a -G sudo,adm vamsiubuntu
reboot



















# This code is compatible with Terraform 4.25.0 and versions that are backward compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "instance-1" {
  boot_disk {
    auto_delete = true
    device_name = "instance-1"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230616"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = true

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-medium"

  metadata = {
    startup-script = "#update local machine\napt update -y && apt-get upgrade -y\n\n#install ubuntu dekstop\napt install ubuntu-desktop -y\n\n#no machine for GUI \nwget https://download.nomachine.com/download/8.5/Linux/nomachine_8.5.3_1_amd64.deb\napt install ./nomachine_8.5.3_1_amd64.deb\n\n#Edge Beta Download\ncurl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg\nsudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg\necho \"deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main\" | sudo tee /etc/apt/sources.list.d/microsoft-edge-beta.list\nsudo apt update\nsudo apt install microsoft-edge-beta\nmicrosoft-edge-beta"
  }

  name = "instance-1"

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

  service_account {
    email  = "ubuntu-automation-17-06-23@ubuntu-automation-17-06-23.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-east1-b"
}
